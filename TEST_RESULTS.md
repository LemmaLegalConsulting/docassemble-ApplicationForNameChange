# Verified local packet tests

On October 4, 2026, all **27 Name Change scenarios / 265 story steps have passing executions** against localhost. This is the latest result for each scenario across a complete run and focused follow-up, not a claim that the full run had no failures. See [the sanitized execution report](validation/alkiln-results.json) for per-run and per-scenario provenance, commit IDs, fixture hashes, and local artifact locations. The earlier application-only baseline is preserved separately.

- Full run on `3147bc5`: **26 passed / 1 failed**, 265 steps (249 passed, 1 failed, 15 skipped). The known-address parental-notice story encountered “Input not processed because the page expired” on the birth-record choice. Its failed HTML/screenshot remain local. No assertion was ignored or input retried automatically.
- Focused run after final presentation/template fixes, `714fd2f`: **5 passed / 60 steps passed**. It includes the previously failed parental route, the adult core packet, full financial disclosures, Hennepin separate orders, and removal of the fee waiver during review.

Coverage includes per-person age-10 releases, a verified dissolution exception, federal felony notices, first/repeat inmate requests, known/unknown parent addresses, unidentified-parent referral, all implemented fee-waiver branches, family and fee-waiver review edits, and age/residency/no-relief/minor-only referrals. Hennepin's generated PDF is asserted to contain two separate orders for a two-person application.

**Seven unit/template regression tests passed.** They verify the independent child-2/child-3 PDF fields, strict resolution of companion template labels, separate per-person releases/orders, unchanged judicial-section XML, conditional fee-waiver suppression, and the service-affidavit title/name separation.

**All ten automated templates passed inventory and output checks**: the 152-field NAM102 PDF plus nine DOCX templates. Fresh strict renders and LibreOffice conversions produced every required PDF. Samples were visually reviewed for caption placement, checkbox duplication, names, execution blanks, signatures, and pagination. FEE102 uses two pages for the synthetic full-financial example; each sample release and inmate affidavit uses one page. Long real answers may expand. Original PDF raster/mapping evidence is retained and the independent verifier passed again. Official static downloads are source documents, not automated templates.

DAYamlChecker reports **zero errors** in default and style modes. Saved reports retain **13 default warnings** and **24 style warnings**, including inherited court-template structure and remaining wording/translation work. These are review work, not legal acceptance. Source legal declarations and court-only order sections are intentionally preserved.

Earlier exploratory failures identified invalid legacy Word metadata and dictionary access in Docassemble's template rendering. Those were fixed and exercised again. Intermittent localhost page-expiry responses remain a test/reliability investigation item rather than being called resolved. Raw artifacts, synthetic downloads, and LHI session pages are kept outside tracked Git files.

The synthetic LHI adult route and its downloaded packet were inspected; full branch parity, client legal review, county acceptance, full accessibility evaluation, and public deployment are still outstanding. See [PACKET_SCOPE.md](PACKET_SCOPE.md) and [IMPROVEMENTS.md](IMPROVEMENTS.md).
