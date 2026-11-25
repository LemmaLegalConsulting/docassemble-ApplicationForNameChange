# Verified local packet tests

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
