"""Share the docassemble namespace without requiring setuptools at runtime."""
from pkgutil import extend_path

__path__ = extend_path(__path__, __name__)
