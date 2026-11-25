# Development setup

Working repo: https://github.com/LemmaLegalConsulting/docassemble-ApplicationForNameChange
Original (`upstream`): https://github.com/AmandaSauber/docassemble-ApplicationForNameChange
Use a development branch from current `main`. The local Docker setup below serves the interview at `http://localhost:8089` and a read-only view of the actual automated browser at `http://127.0.0.1:8090/`. Use synthetic data.

## Static and template checks

```sh
uv venv .venv
uv pip install --python .venv/bin/python -r requirements-dev.txt
.venv/bin/dayamlchecker --style docassemble/ApplicationForNameChange/data/questions
.venv/bin/python -m unittest discover -s tests -p 'test_*.py'
```

DAYamlChecker is pinned to source commit `5676a949ebca269325eb0d8bf0abad52eda4aa61` (source version 1.7.0). URL and accessibility checks stay enabled. Errors fail CI; warnings remain review work. GitHub Actions also runs template regression tests. Use `uv run --no-project --with-requirements requirements-dev.txt ...` if running tools without installing this interview's runtime dependencies.

## Run and watch the interview in local Docker

The existing development container is `namechange-test`. Installation and testing are separate: finish package installation before starting browser suites. The helper uploads tracked and non-ignored new files, checks the installation result, restarts the web workers, waits for server health, and copies the same checkout into the container for testing.

From PowerShell, with the development requirements installed:

```powershell
$env:PYTHONUTF8 = '1'
$env:DOCASSEMBLE_DEVELOPER_API_KEY = 'abcd1234abcd1234abcd5678abdc5678'
.venv\Scripts\python.exe tests/install_local_docker.py
.venv\Scripts\python.exe tests/run_local_docker.py --tags '@validation'
# Run all features, including existing regressions:
.venv\Scripts\python.exe tests/run_local_docker.py
```

The key above belongs only to the disposable synthetic-data container. For another local server, set its key in that environment variable and pass `--server-url` and `--container` to the installer. Never commit real API keys.

Open `http://127.0.0.1:8090/` to watch the tests. The viewer attaches read-only to the actual test browser, preserves its viewport, shows the active scenario, and retains the last image and final result. Reports, screenshots, downloaded documents, and console logs are saved under ignored `.alkiln-artifacts/`. The runner returns a nonzero exit code for failed tests. Use `tests/install_local_docker.py --sync-only` after changing only test files; application changes require installation.

For an independent manual session, open `http://localhost:8089/interview?i=docassemble.ApplicationForNameChange:data/questions/Application_for_name_change.yml&new_session=1`.

### Create the container on a new development machine

Docker Desktop must be running. The setup needs several GB of disk space. From the repository root:

```powershell
New-Item -ItemType Directory -Force .alkiln-artifacts/config | Out-Null
Copy-Item .github/local-docker-config.yml .alkiln-artifacts/config/config.yml
$localConfig = (Resolve-Path .alkiln-artifacts/config).Path
$env:DA_ADMIN_EMAIL = 'admin@example.com'
$env:DA_ADMIN_PASSWORD = 'synthetic-test-password'
$env:DA_ADMIN_API_KEY = 'abcd1234abcd1234abcd5678abdc5678'
docker run --name namechange-test -d --memory=4gb -p 127.0.0.1:8089:80 --env DA_ADMIN_EMAIL --env DA_ADMIN_PASSWORD --env DA_ADMIN_API_KEY --env DA_CONFIG=/tmp/config/config.yml --mount "type=bind,source=$localConfig,target=/tmp/config" jhpyle/docassemble:1.10.7@sha256:c0b0a707a6cd2149d5777ee83af1ea1de544210e597371eac93e67a1503c395c
```

Wait for `http://localhost:8089/health_check?ready=1` to return HTTP 200. Initial startup can take several minutes. Install the Node 22 binary from the official Node image, and the same pinned ALKiln used by CI:

```powershell
docker create --name namechange-node22 node:22-bookworm-slim
docker cp namechange-node22:/usr/local/bin/node .alkiln-artifacts/node22-linux
docker exec namechange-test mkdir -p /tmp/node22
docker cp .alkiln-artifacts/node22-linux namechange-test:/tmp/node22/node
docker rm namechange-node22
docker exec -e PATH=/tmp/node22:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin -e PUPPETEER_SKIP_DOWNLOAD=true namechange-test npm install --install-strategy=nested --prefix /tmp/alkiln @suffolklitlab/alkiln@5.17.1
```

The pinned docassemble image provides Chrome and `pdftotext`; the runner uses that Chrome explicitly. The container's `preloaded modules` setting registers AssemblyLine's custom BirthDate datatype. The package uses the standard-library docassemble namespace rather than `pkg_resources`.

## ALKiln story tables

Fixtures: `docassemble/ApplicationForNameChange/data/sources/scenarios.feature`.
Narratives and expected behavior: [TEST_SCENARIOS.md](TEST_SCENARIOS.md).

```sh
# Requires a checkout of ALKiln with its npm dependencies and Chromium installed.
# Defaults to ~/ALKiln; override ALKILN_PATH if needed.
.venv/bin/python tests/run_alkiln.py .
# Optional second argument is a Cucumber tag expression.
```

The runner uses the `localhost` entry in `~/.docassemblecli`, without printing or storing its key in tracked files. Install the package first. It tests the installed package rather than uploading a Playground. Reports, screenshots, and synthetic downloads go to ignored `.alkiln-artifacts/`. It requires Node, Chromium/Puppeteer, PyYAML, and `pdftotext` (Poppler).

Tested ALKiln checkout: `d7e4f42aa8a828013a8a229067697decf1322e5f`. `tests/steps.cjs` contains PDF assertions and narrow compatibility fixes for current Docassemble: button containers are divs, checkbox state is read from the native input, and Resume may change the question without changing the URL. Read-only error queries retry briefly if navigation replaces the DOM; input actions and assertion failures are never ignored. It also stops promptly on AssemblyLine's custom error screen. These are test-harness changes, not suppressed application failures. Reassess them when upgrading ALKiln.

## Template audit and decisions

`validation/template-labels.json` records the current labels and control tags. `validation/template-verification.json` records strict synthetic rendering and PDF checks. The workspace `scripts/audit_current_templates.py` refreshes the label inventory. The package `scripts/render_packet_examples.py` renders all current companion DOCX templates with strict synthetic data and checks LibreOffice PDF conversion. Unit tests check the NAM102 PDF mappings. The workspace `scripts/verify_templates.py ApplicationForNameChange` also checks the original PDF appearance and all DOCX templates using the expanded packet context. Early one-time migration scripts are historical and should not be rerun against the edited templates.

Keep wet signatures, initials, execution dates, and witness/notarial attestations manual. Record substantive choices and sources in [DECISIONS.md](DECISIONS.md); keep the remaining release decisions in [IMPROVEMENTS.md](IMPROVEMENTS.md).

Build the labeled court templates with `scripts/build_packet_templates.py` (LibreOffice required for archived legacy Word sources) and the fee/checklist adaptations with `scripts/build_fee_templates.py`. Originals and retrieval hashes are archived under `reference/court-originals/`. Run template regressions after rebuilding.

Use `scripts/summarize_alkiln.py ARTIFACT_DIR APPLICATION_COMMIT [ARTIFACT_DIR APPLICATION_COMMIT ...]` to save a sanitized report across a full run and later focused verification. It requires coverage of the current scenario set, uses the newest result for each scenario, preserves each run's totals, and omits session URLs and step arguments.

## Editing reliability and expiry investigation

Run the targeted story tables against an installed copy of this checkout:

```sh
.venv/bin/python tests/run_alkiln.py . '@editing_reliability'
node --test tests/navigation.test.cjs tests/page_expiry.test.cjs
```

Project hooks must load after ALKiln's hooks, as both local runners now arrange. Each scenario has an isolated browser context. The preceding context closes only after ALKiln has saved artifacts and completed its cleanup. Repeated downloads are archived before downloading the regenerated file; assertions inspect the fresh PDF.

The project treats Docassemble's success-styled “Input not processed because the page expired” alert as a failure. Do not dismiss it, resubmit automatically, or weaken the security-token checks. Preserve failed artifacts and rerun the affected scenario independently. `submission-trace.json` records step-time request paths and timing plus token/cookie fingerprints; query strings, cookies, and raw tokens are omitted. The trace ends before ALKiln's sign-out cleanup; examine server logs separately for teardown errors.

On Windows, set `PYTHONUTF8=1` before running DAYamlChecker. Restrict its input to the question directory so it does not recursively inspect examples in `.venv` or ignored browser artifacts. URL and accessibility checks remain enabled.

## Financial validation maintenance

`docassemble/ApplicationForNameChange/data/sources/poverty_guidelines.json` contains dated, sourced HHS figures for the contiguous states. Add each new year's one-person amount and additional-person increment, verify the published 125% table, and extend the boundary tests in `tests/test_financial_validation.py`. An unknown year falls back to asking the user to check the current court guideline; it does not reuse an older year's figure.

The FEE102 adaptation distinguishes income **less than** 125% from income **greater than or equal to** it. At the exact boundary this interview collects the remaining financial details; it still permits a fee-waiver request. The court makes the decision. Household size is the applicant plus structured household entries. Other household income is monthly take-home pay, while the separate yearly total is before deductions; those figures must not be treated as interchangeable.


## Document stress and layout checks

Run `tests/run_local_docker.py --tags '@document_stress'` after installing the checkout. The cases cover extended Latin names, CJK names, long statements/property/financial explanations, six Hennepin orders, three signing-age minors, and removal of one signing minor. The assertions check fresh documents after edits, full names, declaration ends, signature-sheet names, independent findings numbering, and the absence of footer-only order pages.

`requirements-runtime.txt` lists the PDF renderer dependencies also declared by setup.py. The local installer installs them in the Docassemble virtual environment because zip updates may retain older dependency metadata. It then restarts web workers. `--sync-only` copies test sources; it does not update the installed interview or its dependencies.

For visual QA, install optional local PyMuPDF and Pillow, then run `python scripts/review_stress_pdfs.py ARTIFACT_DIR .alkiln-artifacts/document-stress-fixed/rendered`. Inspect the PNGs as well as PDF text: fixed field appearances can lose characters even when stored field values are correct. Cross-render the application with Docker's `pdftoppm`; verify canonical field values and embedded appearance streams. Checkboxes use vector marks, so small glyphs are not needed. Rebuild the order from originals with `scripts/build_packet_templates.py`, which applies `scripts/order_layout.py` after labeling.
