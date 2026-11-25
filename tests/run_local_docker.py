"""Run the installed interview in Docker and show its actual browser at localhost:8090."""
import argparse
from datetime import datetime
import os
from pathlib import Path
import subprocess
import sys
import urllib.request

from install_local_docker import ROOT, source_files, sync_sources


def docker(container, *args, **kwargs):
    return subprocess.run(['docker', 'exec', container, *args], check=True, **kwargs)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--container', default='namechange-test')
    parser.add_argument('--tags', default='not @manual')
    args = parser.parse_args()
    if not os.environ.get('DOCASSEMBLE_DEVELOPER_API_KEY'):
        parser.error('Set DOCASSEMBLE_DEVELOPER_API_KEY for the local server.')
    sync_sources(source_files(), args.container)
    # Fail clearly if the supported runtime/runner has not been provisioned.
    docker(args.container, 'test', '-x', '/tmp/node22/node')
    docker(args.container, 'test', '-f', '/tmp/alkiln/node_modules/@suffolklitlab/alkiln/lib/index.js')
    live = ROOT / '.alkiln-artifacts/config/live'
    live.mkdir(parents=True, exist_ok=True)
    (live / 'index.html').write_text((ROOT / 'tests/live_docker_view.html').read_text(encoding='utf-8-sig'), encoding='utf-8')
    try:
        urllib.request.urlopen('http://127.0.0.1:8090/', timeout=2).close()
    except OSError:
        flags = {'creationflags': subprocess.CREATE_NO_WINDOW} if os.name == 'nt' else {'start_new_session': True}
        with (ROOT / '.alkiln-artifacts/live-server.log').open('a') as log:
            subprocess.Popen([sys.executable, '-m', 'http.server', '8090', '--bind', '127.0.0.1', '--directory', str(live)], stdout=log, stderr=log, **flags)
    docker(args.container, 'sh', '-c', ': > /tmp/namechange-local.log')
    # Replace only viewers started by this project; do not touch the test browser.
    stop = "import os; from pathlib import Path; names={b'/tmp/live-view.cjs',b'/tmp/validation-status.py',b'/tmp/namechange-source/tests/live_docker_view.cjs'}; [os.kill(int(p.name),15) for p in Path('/proc').iterdir() if p.name.isdigit() and p.name!=str(os.getpid()) and names.intersection((p/'cmdline').read_bytes().split(bytes([0])))]"
    docker(args.container, 'python3', '-c', stop)
    stamp = datetime.now().strftime('%Y%m%d-%H%M%S')
    remote_artifacts = '/tmp/namechange-artifacts/' + stamp
    environment = [
        '-e', 'PATH=/tmp/node22:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        '-e', 'ALKILN_PATH=/tmp/alkiln/node_modules/@suffolklitlab/alkiln',
        '-e', 'SERVER_URL=http://localhost', '-e', 'DOCASSEMBLE_DEVELOPER_API_KEY',
        '-e', 'REPO_URL=https://github.com/LemmaLegalConsulting/docassemble-ApplicationForNameChange',
        '-e', 'BRANCH_NAME=' + subprocess.check_output(['git','branch','--show-current'],cwd=ROOT,text=True).strip(),
        '-e', '_ORIGIN=github', '-e', 'PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome',
        '-e', 'ALKILN_TAG_EXPRESSION=' + args.tags, '-e', 'ALKILN_ARTIFACTS_PATH=' + remote_artifacts,
        '-e', 'TZ=America/Chicago',
    ]
    subprocess.run(['docker','exec','-d',*environment,args.container,'/tmp/node22/node','/tmp/namechange-source/tests/live_docker_view.cjs'],check=True)
    print('Live Docker browser: http://127.0.0.1:8090/',flush=True)
    result=subprocess.run(['docker','exec','-w','/tmp/namechange-source',*environment,args.container,'bash','-c','set -o pipefail; python3 tests/run_alkiln_ci.py 2>&1 | tee /tmp/namechange-local.log'])
    local=ROOT / '.alkiln-artifacts' / stamp
    subprocess.run(['docker','cp',args.container+':'+remote_artifacts,str(local)],check=True)
    print('Saved browser reports:',local,flush=True)
    return result.returncode


if __name__=='__main__':
    sys.exit(main())
