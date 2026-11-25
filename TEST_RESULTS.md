# Verified local packet tests

## November 25, 2026: GitHub container dependency setup

The first PR #7 isolated browser run (`45640989660`, head `f9ee64f`) failed at interview import with `ModuleNotFoundError: No module named pypdf`. Host-side PDF validation dependencies were installed successfully, but the Docassemble container used a separate virtual environment. This failure did not exercise the document stress assertions.

The workflow now copies `requirements-runtime.txt` into the disposable container, finds its Docassemble virtual-environment Python, installs the requirements there, and explicitly imports `PdfReader`, `PdfWriter`, and ReportLab before restarting web workers. The runner-side installation remains for checking downloaded PDF files. The workflow YAML, Bash syntax, step order, and exact in-container installation/import block were verified against the pinned local image. Application and template code are unchanged by this setup repair. A new PR-triggered run will verify the fix on a fresh server; the earlier failure is retained rather than rerun on the old revision.

## November 25, 2026: repaired document stress failures

Implemented the four layout repairs from the baseline below. Docker verification on the final installed application/renderer/order hashes passed **9 scenarios / 208 steps**, covering the three stress cases, all four editing-reliability cases, the ordinary adult route, and county changes. **25 Python regressions and 10 navigation/expiry checks pass.** Scoped YAML/style checks: **0 errors, 6 warnings, 10 informational findings**. See [the sanitized baseline and repair record](validation/document-stress-review.json).

- NAM102 has embedded DejaVu/Droid TrueType appearance streams and vector checkbox marks. Tested CJK and extended-Latin names render in both Poppler and MuPDF, with no Poppler font diagnostics. All 152 canonical fields remain, and values match their widgets. A standalone validator also checks embedded fonts, 9-point minimum generated text, and all 25 checkbox states in downloaded applications.
- Complete values that cannot fit at 9-11 points move to numbered, labeled continuation entries. The field and its logical value contain the same reference. Full 7,531-character statements and 2,999-character property descriptions were independently compared against the continuation body text after removing navigation headers/footers. No content is split by a character-count threshold at a clipped field boundary.
- Each included child age 14 or older gets a separate blank manual signature/date/place block with the original NAM102 perjury declaration and full printed name. Removing the first of three signing-age minors regenerates two blocks and removes the former child's block. No signatures or execution dates are automated.
- All three NAM107 numbering groups restart (findings 1-9), and one-point loop-break paragraphs remove footer-only pages. The six-order stress packet decreases from 22 to **18 pages**, with no footer-only pages. After removal of a child, five orders occupy 15 pages. Regression tests retain exact original XML for the judicial section beginning IT IS ORDERED.

Rendered 13 final stress PDFs / 88 pages, including the before/after family-edit downloads. Cross-rendered all stress application pages in Poppler and MuPDF and inspected names, continuation boundaries, checkboxes, signature space, and order numbering/pagination. The final geometry scan flags **no off-page spans or text below 8 points**. Local artifacts: `.alkiln-artifacts/20261125-085331` and `.alkiln-artifacts/document-stress-fixed/`.

An earlier intermediate run (`20261125-084456`) passed 3 scenarios / 41 steps. Visual inspection then caught the remaining decimal list groups and checkbox fallback marks; both were fixed before the final run and gained explicit regressions. The first repair attempt (`20261125-084217`) failed at interview load because zip package updates did not install the newly declared pypdf dependency. The local installer now installs `requirements-runtime.txt` in Docassemble's virtual environment before restarting workers. The local viewer cleanup also handles processes exiting during `/proc` enumeration; application input errors and expiry/security failures remain failures.

These results cover the synthetic configurations and writing systems tested. Court acceptance of continuation/signature supplements, other writing systems/shaping, broader companion layouts, and the remaining accessibility/client review are still open. The older baseline evidence below is retained for comparison.

## November 25, 2026: local document stress and layout review

Reviewed merged main at `88f9953` in the existing `namechange-test` Docker container. SHA-256 comparisons confirmed that all 14 installed question/template files match this checkout. All names, property descriptions, and declarations are synthetic. No application code or court templates changed; nothing was pushed to GitHub.

Added `docassemble/ApplicationForNameChange/data/sources/document_stress.feature` and the optional local rendering helper `scripts/review_stress_pdfs.py`. Run the feature explicitly with `tests/run_local_docker.py --tags '@document_stress'`. These are **known-failing stress regressions**, not a green release suite. The renderer needs local PyMuPDF and Pillow; rendered PDFs, page PNGs, contact sheets, geometry, stored-field comparisons, and failed artifacts remain under ignored `.alkiln-artifacts/document-stress-review/`. The sanitized record is [validation/document-stress-review.json](validation/document-stress-review.json).

| Configuration | Application | Proposed orders | Releases | Other |
| --- | --- | --- | --- | --- |
| Long accented names; 7,531-character declaration; 2,999-character property description | 9 pages | 6 pages | 1 page | Fee waiver 3 pages; next steps 1 page |
| CJK current/requested names | 6 pages | 3 pages | 1 page | — |
| Adult and five children with long names; three minors age 14+; Hennepin | 7 pages | 22 pages (six orders) | 6 pages | — |

Rendered and visually reviewed 11 distinct PDFs / 65 pages, with detailed inspection of captions, child rows, declaration boundaries, signature areas, and order breaks. NAM102 page 1 was also rendered in Poppler to compare with MuPDF. PDF text alone misses the clipping and signature-capacity problems.

**Open defects:**

1. **Unicode rendering portability:** NAM102 preserves the complete field values, but Poppler renders the tested CJK name fields blank and omits extended Latin glyphs. MuPDF can display the CJK names through fallback. The DOCX-derived companion forms preserve the tested names. Embedded/portable appearances need repair and cross-renderer verification.
2. **Long names and fixed PDF fields:** caption first names shrink to about **4.43 pt**. Applicant/child surnames and signature-area printed names clip in MuPDF. The property field's bottom line is also clipped before the continuation starts in its addendum; a start/end marker assertion alone does not establish that every intervening character is legible.
3. **Minor signature capacity:** three signing-age minors still share one minor signature/date line and one clipped printed-name field. No additional signature sheet is generated. Adult, fee-waiver, release, and judicial signature lines remain blank for manual execution.
4. **Repeated-order pagination and numbering:** six Hennepin orders expand to **22 pages**, including footer-only pages **7, 11, 15, and 19**. Findings numbering continues between separate orders. Judicial signature areas remain present, but the packet needs pagination/numbering repair.

**What held up:** lengthy statements and financial explanations wrap over additional pages rather than covering the signature blocks. The application includes its statement/property addendum. All 60 statement section labels are present across the application and its addendum, and all 30 financial explanation items survive. The 3-page fee affidavit keeps its perjury/date/signature block together. Each of the six criminal releases occupies its own page with a clear signature line. No off-page text boxes were flagged by the geometry helper; this does not establish that fixed-field text is uncut.

**Run history:** `.alkiln-artifacts/20261125-014308`: 3 scenarios, 2 failed / 1 passed, 39 steps (32 passed, 2 failed, 5 skipped). Its fee end-marker failure was caused by a hyphenated marker breaking at a line wrap. Replaced it with an unbroken marker and added exact long-name checks. `.alkiln-artifacts/20261125-014649`: 2 scenarios, 1 failed / 1 passed, 29 steps (27 passed, 1 failed, 1 skipped). The corrected declaration marker passes; the long original surname fails as expected. Combining the latest Latin/family cases with the unchanged CJK case leaves **two real name-rendering failures and one text-passing family case with visual defects**. Failed assertions were retained, not weakened or suppressed. The final family fixture includes three minors age 14 or older. The initial family fixture had younger children and is retained as historical evidence.

This is a layout review of these configurations, not court acceptance, all-script Unicode support, or a full accessibility audit. Next: repair NAM102 Unicode/long-field appearances and continuation handling, add minor signature capacity, then fix repeated-order blank pages/numbering and rerun the same cases in both renderers.

## November 24, 2026: local editing reliability

Tested the working changes based on local `main` at `1ab3f6f`. The separate `codex/name-change-validation` branch was inspected locally to exclude its financial validation, child-name/age validation, and county-recalculation work. No commits, pushes, pull requests, or other GitHub actions were performed.

Two reproduced packet-editing bugs were fixed:

- Deleting the first child reused that child's requested name for a remaining child. Requested-name answers now stay with their child when rows move. A newly added child gets fresh requested-name questions. Synchronization also runs when leaving the family review table.
- Removing an applying spouse silently reassigned their felony notice to the next person in the packet. Notice selections now follow the selected person. A removed recipient requires review, with an explanation and a link to edit the offenses; remaining recipients keep their selections.

Verified browser runs against the disposable local Docassemble installation:

| Local artifact directory | Result | Coverage |
| --- | --- | --- |
| `.alkiln-artifacts/editing-20261124-201906` | **4 scenarios / 118 steps passed** | Notice-route changes; family branch removal/restoration; child deletion/addition; two felony notices after spouse removal. |
| `.alkiln-artifacts/editing-20261124-202059` | **7 scenarios / 99 steps passed** | Existing adult-only, three-child, spouse, child-removal, known-address notice, unknown-address publication, and federal-notice cases, using isolated browser cookies/storage. |
| `.alkiln-artifacts/editing-20261124-202651` | **1 scenario / 18 steps passed** | Independent final verification of the recipient-removal warning and updated notices, using isolated browser cookies/storage. |

These are focused runs, not a new execution of every historical scenario. Downloads were regenerated after edits and their PDF text was asserted. The child-removal and spouse-notice failures were reproduced before their fixes; failed HTML, screenshots, and PDFs remain in the ignored local artifact directories. The first notice-edit attempt failed on a test label's apostrophe rendering; correcting the fixture did not require an interview change. See the sanitized [editing investigation report](validation/editing-reliability-results.json) for provenance and retained run outcomes.

**12 Python unit/template tests passed**, including child-row identity and felony-recipient remapping. **10 Node checks passed** for navigation and expiry detection. Scoped DAYamlChecker validation of the question directory reported no issues in default mode; style mode reported **0 errors, 6 warnings, and 7 informational findings**. These scoped checks do not replace the earlier complete template/accessibility audit. On Windows, UTF-8 mode is needed; scanning the repository root also reaches dependency examples in `.venv`, so the final checker input was restricted to the interview's question directory.

### Page-expiry investigation

The displayed expiry message comes from the server rejecting a CSRF security token. The installed ALKiln checks danger alerts, but Docassemble renders this message as a success alert. The project now explicitly fails on that alert rather than allowing the story table to continue and potentially resubmit an answer. A separate synthetic browser probe deliberately submitted an invalid token; it produced the actual expiry alert, and the guard rejected it without resubmission. Its screenshot and HTML are retained locally as `.alkiln-artifacts/expiry-probe.*`.

Browser scenarios now use separate cookies/storage. Sanitized `submission-trace.json` files retain request timing, paths without query strings, and token/cookie fingerprints; they omit raw tokens, cookies, and session URLs. No in-interview `csrf_error` responses were recorded in the four new or seven existing passing scenarios or the independent final warning check. Some server token errors coincide with ALKiln sign-out cleanup after the scenario trace ends. That distinction avoids treating teardown log entries as proof of an interview failure.

**The root cause of the earlier intermittent interview-time expiry is not established and is not marked fixed.** Keep failed artifacts and rerun affected scenarios independently if it recurs. Security checks remain enabled, and input/assertion failures are not ignored or retried. Court/client acceptance, wider editing combinations, and full accessibility review remain open.

## October 4, 2026: historical packet verification

On October 4, 2026, all **27 Name Change scenarios / 265 story steps have passing executions** against localhost. This is the latest result for each scenario across a complete run and focused follow-up, not a claim that the full run had no failures. See [the sanitized execution report](validation/alkiln-results.json) for per-run and per-scenario provenance, commit IDs, fixture hashes, and local artifact locations. The earlier application-only baseline is preserved separately.

- Full run on `3147bc5`: **26 passed / 1 failed**, 265 steps (249 passed, 1 failed, 15 skipped). The known-address parental-notice story encountered “Input not processed because the page expired” on the birth-record choice. Its failed HTML/screenshot remain local. No assertion was ignored or input retried automatically.
- Focused run after final presentation/template fixes, `714fd2f`: **5 passed / 60 steps passed**. It includes the previously failed parental route, the adult core packet, full financial disclosures, Hennepin separate orders, and removal of the fee waiver during review.

Coverage includes per-person age-10 releases, a verified dissolution exception, federal felony notices, first/repeat inmate requests, known/unknown parent addresses, unidentified-parent referral, all implemented fee-waiver branches, family and fee-waiver review edits, and age/residency/no-relief/minor-only referrals. Hennepin's generated PDF is asserted to contain two separate orders for a two-person application.

**Seven unit/template regression tests passed.** They verify the independent child-2/child-3 PDF fields, strict resolution of companion template labels, separate per-person releases/orders, unchanged judicial-section XML, conditional fee-waiver suppression, and the service-affidavit title/name separation.

**All ten automated templates passed inventory and output checks**: the 152-field NAM102 PDF plus nine DOCX templates. Fresh strict renders and LibreOffice conversions produced every required PDF. Samples were visually reviewed for caption placement, checkbox duplication, names, execution blanks, signatures, and pagination. FEE102 uses two pages for the synthetic full-financial example; each sample release and inmate affidavit uses one page. Long real answers may expand. Original PDF raster/mapping evidence is retained and the independent verifier passed again. Official static downloads are source documents, not automated templates.

DAYamlChecker reports **zero errors** in default and style modes. Saved reports retain **13 default warnings** and **24 style warnings**, including inherited court-template structure and remaining wording/translation work. These are review work, not legal acceptance. Source legal declarations and court-only order sections are intentionally preserved.

Earlier exploratory failures identified invalid legacy Word metadata and dictionary access in Docassemble's template rendering. Those were fixed and exercised again. Intermittent localhost page-expiry responses remain a test/reliability investigation item rather than being called resolved. Raw artifacts, synthetic downloads, and LHI session pages are kept outside tracked Git files.

The synthetic LHI adult route and its downloaded packet were inspected; full branch parity, client legal review, county acceptance, full accessibility evaluation, and public deployment are still outstanding. See [PACKET_SCOPE.md](PACKET_SCOPE.md) and [IMPROVEMENTS.md](IMPROVEMENTS.md).
