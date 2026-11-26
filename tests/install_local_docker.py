"""Install this checkout into a local docassemble server and sync Docker test sources."""
import argparse
import io
import os
from pathlib import Path
import subprocess
import tarfile
import time
import zipfile
import requests

ROOT = Path(__file__).resolve().parents[1]


def source_files():
    output = subprocess.check_output(['git', 'ls-files', '--cached', '--others', '--exclude-standard', '-z'], cwd=ROOT)
    return [ROOT / name for name in output.decode('utf-8').split('\0') if name and (ROOT / name).is_file()]


def sync_sources(files, container):
    archive = io.BytesIO()
    with tarfile.open(fileobj=archive, mode='w') as bundle:
        for path in files:
            bundle.add(path, arcname=path.relative_to(ROOT).as_posix(), recursive=False)
    # Mirror this checkout: an overlay leaves tests from a previous branch behind.
    subprocess.run(['docker', 'exec', container, 'python3', '-c',
                    "from pathlib import Path; import shutil; p=Path('/tmp/namechange-source'); "
                    "assert p.is_absolute() and str(p)=='/tmp/namechange-source'; "
                    "shutil.rmtree(p,ignore_errors=True); p.mkdir()"], check=True)
    subprocess.run(['docker', 'exec', '-i', container, 'tar', '-xf', '-', '-C', '/tmp/namechange-source'], input=archive.getvalue(), check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--server-url', default='http://localhost:8089')
    parser.add_argument('--container', default='namechange-test')
    parser.add_argument('--sync-only', action='store_true', help='Copy test/source files without reinstalling or restarting the server.')
    args = parser.parse_args()
    if args.sync_only:
        sync_sources(source_files(), args.container)
        print('Docker test sources synchronized.')
        return
    key = os.environ.get('DOCASSEMBLE_DEVELOPER_API_KEY')
    if not key:
        parser.error('Set DOCASSEMBLE_DEVELOPER_API_KEY for your local server.')
    base = args.server_url.rstrip('/')
    files = source_files()
    archive = io.BytesIO()
    with zipfile.ZipFile(archive, 'w', zipfile.ZIP_DEFLATED) as bundle:
        for path in files:
            bundle.write(path, 'ApplicationForNameChange/' + path.relative_to(ROOT).as_posix())
    archive.seek(0)
    headers = {'X-API-Key': key}
    response = requests.post(base + '/api/package', headers=headers, files={'zip': ('package.zip', archive, 'application/zip')}, timeout=60)
    response.raise_for_status()
    task = response.json()['task_id']
    print('Package uploaded. Waiting for installation.', flush=True)
    deadline = time.monotonic() + 600
    while time.monotonic() < deadline:
        try:
            response = requests.get(base + '/api/package_update_status', headers=headers, params={'task_id': task}, timeout=10)
            if response.status_code == 200:
                status = response.json()
                if status.get('status') in ('completed', 'unknown'):
                    if not status.get('ok'):
                        raise RuntimeError('Local package installation failed: ' + status.get('error_message', status.get('status', 'unknown')))
                    break
        except requests.exceptions.ConnectionError:
            pass
        except requests.exceptions.Timeout:
            pass
        time.sleep(2)
    else:
        raise TimeoutError('Local package installation did not finish within 10 minutes.')
    if args.container:
        sync_sources(files, args.container)
        # Zip updates can retain an existing package's dependency metadata.
        # Install the declared PDF runtime requirements into docassemble's venv,
        # not the container's unrelated system Python, before restarting workers.
        install_runtime = "from pathlib import Path; import subprocess; candidates=list(Path('/usr/share/docassemble').glob('local*/bin/python')); assert len(candidates)==1, candidates; subprocess.run([str(candidates[0]), '-m', 'pip', 'install', '-r', '/tmp/namechange-source/requirements-runtime.txt'],check=True)"
        subprocess.run(['docker', 'exec', args.container, 'python3', '-c', install_runtime], check=True)
        subprocess.run(['docker', 'exec', args.container, 'supervisorctl', 'restart', 'uwsgi'], check=True)
    deadline = time.monotonic() + 180
    while time.monotonic() < deadline:
        try:
            response = requests.get(base + '/health_check?ready=1', timeout=5)
            if response.status_code == 200:
                print('Local server ready; checkout and Docker test sources installed.', flush=True)
                return
        except requests.exceptions.RequestException:
            pass
        time.sleep(2)
    raise TimeoutError('Local server did not become ready after installation.')


if __name__ == '__main__':
    main()
