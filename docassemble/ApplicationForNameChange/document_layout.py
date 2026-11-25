"""Apply NAM102 layout repairs to individual and bundled AssemblyLine downloads."""
from pathlib import Path
import shutil
from tempfile import TemporaryDirectory

from docassemble.AssemblyLine.al_document import ALDocument
from .pdf_layout import repair_application

__all__ = ['NameChangeApplication']


class NameChangeApplication(ALDocument):
    def as_pdf(self, *args, **kwargs):
        result = super().as_pdf(*args, **kwargs)
        if result is None:
            return result
        with TemporaryDirectory() as folder:
            output = Path(folder) / 'application.pdf'
            repair_application(result.path(), output, self.minor_signers)
            shutil.copyfile(output, result.path())
        result.commit()
        return result
