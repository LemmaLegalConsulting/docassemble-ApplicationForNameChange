"""A package install must not break docassemble on modern server images."""
from pathlib import Path
from tempfile import TemporaryDirectory
import subprocess
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]

class NamespaceCompatibility(unittest.TestCase):
    def test_namespace_import_without_setuptools(self):
        with TemporaryDirectory() as directory:
            namespace = Path(directory) / 'docassemble'
            namespace.mkdir()
            (namespace / '_namespace_probe.py').write_text('value = 42\n')
            # -S removes site-packages, including setuptools/pkg_resources.
            # A second namespace location must still be discoverable.
            result = subprocess.run(
                [sys.executable, '-S', '-c',
                 'import sys; sys.path.append(sys.argv[1]); '
                 'import docassemble.ApplicationForNameChange; '
                 'from docassemble._namespace_probe import value; '
                 'assert value == 42; assert "pkg_resources" not in sys.modules',
                 directory], cwd=ROOT, capture_output=True, text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
