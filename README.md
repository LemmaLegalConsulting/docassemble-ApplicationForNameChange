# docassemble.ApplicationForNameChange

Minnesota adult name change packet

## Author

Coleman Silver


## Development status

See [DEVELOPMENT.md](DEVELOPMENT.md) for setup and validation, and [IMPROVEMENTS.md](IMPROVEMENTS.md) for prioritized remaining work. These interviews are development drafts; passing static checks is not production acceptance.

Narrative acceptance scenarios: [TEST_SCENARIOS.md](TEST_SCENARIOS.md). Implementation rationale: [DECISIONS.md](DECISIONS.md).

Packet coverage and LHI comparison: [PACKET_SCOPE.md](PACKET_SCOPE.md).


## Isolated ALKiln environment

The workflow uses a temporary, pinned docassemble image and Node 22 with ALKiln 5.17.1. It runs all feature files, including PDF-content assertions and review-screen editing scenarios, and uploads browser reports and generated documents.

The server preloads `docassemble.ALToolbox.ThreePartsDate` to register AssemblyLine's `BirthDate` datatype before parsing interview YAML. After package installation, the job restarts the web workers and waits up to 180 seconds for `/health_check?ready=1`. Startup failures include the web-worker logs and service status.

This package shares the `docassemble` namespace with Python's standard-library `pkgutil`, so importing it does not require the removed `pkg_resources` module. A regression test verifies imports without setuptools and discovery of a second namespace location.

Run `python -m unittest discover -s tests -p "test_*.py"` and `node --test tests/navigation.test.cjs` for focused regressions. See [GitHub Actions](https://github.com/LemmaLegalConsulting/docassemble-ApplicationForNameChange/actions) for current full-suite results. Court-content review and release decisions remain listed in [IMPROVEMENTS.md](IMPROVEMENTS.md).
