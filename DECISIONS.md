# Implementation decisions

## Working conventions — 2026-10-04

- **Prioritize implementation over estimating remaining agent time.** Quinten wants most human hours reserved for feedback and iteration. Keep unresolved choices visible, but make ordinary development decisions without repeatedly seeking confirmation.
- **Use focused commits.** Separate template repair, interview behavior, document content, and infrastructure where they can be reviewed and tested independently. The initial setup commit established the repositories, validator, and review baseline; subsequent commits should have narrower subjects.
- **Use the Assembly Line style guide as the default.** Favor sentence case, short active instructions, related fields grouped into small screens, conditional follow-ups, and useful offramps. Treat lint output as review evidence, not authority to change substantive legal language.
- **Preserve proven interfaces.** Keep unique PDF field names and their suffixes. Preserve legitimate radio groups and repeated appearances of the same field; repair only incorrect links or mappings.
- **Separate evidence levels.** Static checks, synthetic template renders, browser walkthroughs, and client content approval answer different questions. Do not call any one of them production acceptance.

## References consulted

- [Assembly Line style guide](https://assemblyline.suffolklitlab.org/docs/style_guide/): local `~/AssemblyLine-docs/docs/style_guide/`, including readability, formatting, field organization, input validation, and exit screens.
- `~/all_interviews/repos/docassemble-PetitionToChangeNameOfAdult/.../petition_to_change_name_of_adult.yml`: mandatory controller, explicit branching, review actions, and preview/download patterns. Existing legacy style in this reference is not copied wholesale.
- `~/all_interviews/repos/docassemble-CLAGuardianship/.../caregiver_authorization_affidavit.yml`: person collection and caregiver-related questions. Massachusetts legal rules are not carried over.
- `~/docassemble-ALDashboard`: field-name contract, deterministic DOCX run edits and syntax checks, and accessible field labels.

## Initial template decisions

Preserve wet signatures, initials, execution dates, and witness/notary attestations for completion when signing. Add automation labels for information gathered by the interview. The PDFs' original unfilled page rasters were compared before/after field edits; they matched. The Name Change child-2 surname needed its own field because the original erroneously shared child 3's value. The shared foreclosure owner field is intentional and retained.

## Restore the LawHelpMN asset

Reuse the same `MNfavicon-96x96.png` already supplied in Amanda’s Health Care Directive package. Both interviews referenced that exact filename but omitted it. This restores the existing intended branding without introducing a new logo or changing the interview’s theme.

## Consistent help links — 2026-10-04

Use the verified matching LawHelpMN resource, [Name Change - Minnesota Court Forms and Information](https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information), in publishing metadata, the introduction, the download screen, and printable next steps. Keep direct court/statutory sources for form requirements. Name Change’s matching resource is a court-forms directory, not an Education for Justice fact sheet. No claim of LHI feature parity is made.

## Repair conditional gathering and output

Ask about marriage and minor children before gathering people. Gather actual children instead of unconditionally requesting five birthdates. List a spouse even when not applying, as the printed form requires, but collect signature/contact details only for an included spouse. Derive the mutually exclusive criminal-history checkboxes from one answer. Split felony rows and requested child names into smaller screens. Guard dormant PDF mappings so editing a branch to No cannot print retained answers. Correct the city/state/ZIP field to address.line_two(). Remove arbitrary short name limits.

Preserve the supplied NAM102 (Rev 7/23) pending current-packet comparison; this package produces an application, not a complete filing packet. The five-row paper limits currently use an explicit extra-sheet instruction. Narrative scenarios will expose remaining review/overflow/usability gaps.

## Scenario-driven runtime fixes

Add an explicit residence-county question because AssemblyLine does not supply that fallback. Set ask_number=True with a target of one spouse to prevent an unrelated additional-spouse loop. Both were found by exercising the narrative fixtures, not by static linting.

## Testing approach

Use narrative ALKiln story tables plus assertions against downloaded PDF text. Include negative paths, recording-date/deadline boundaries, optional people, long text, and review edits. Save raw artifacts locally and commit only a sanitized execution summary. Keep synthetic unit/template checks in CI. Distinguish failures in test-tool compatibility from actual interview defects; document both, and never turn a failed expectation into a pass without explaining the change.

- Clean GitHub CI exposed an implicit PyYAML dependency in the PDF mapping regression test. Pin PyYAML in development requirements so the test does not depend on the workstation environment.

## Expand to the court packet — 2026-10-04

Quinten explicitly requested the full required packet. Supersede the earlier application-only scope. Compare the live LHI 5664 adult flow (including qualification, birth records, release data, and optional fee waiver) with current NAM101 Rev 2/25. Retain the supplied repaired NAM102 Rev 7/23 because that is also the current court revision. Do not claim pixel identity with the newly downloaded original: there are existing field-overlay differences.

Archive court originals and SHA-256 hashes. Label published NAM103, NAM104, NAM105, NAM107, NAM205, and NAM207 Word forms, using LibreOffice for legacy DOC conversion. Do not fill the judicial order section, judge signature, hearing date, service attestations, execution dates, or notice/no-objection findings. Normalize an invalid legacy core-properties relationship before rendering: otherwise docxtpl creates duplicate ZIP entries and LibreOffice rejects the result. Compact conversion-only spacing in release and inmate forms; long answers can expand naturally.

Generate NAM103 for covered people age 10 and older, including children whose requested names are nonblank. Derive packet names from actual selected people rather than parsing a free-text list. A verified sole-adult post-dissolution exception omits the release and requires certified source documents. Repeated inmate requests and minor-only changes get explicit offramps rather than a false affidavit or adult application.

NAM107 is prefilled only above IT IS ORDERED. The unchanged judicial section is checked against the court original. NAM104 is generated for each listed felony offense, with an explicit person and prosecuting jurisdiction; federal/out-of-state convictions mark the Attorney General recipient. The user still must serve the application and provide actual proof of service.

For included children sharing one non-applicant parent, generate a hearing notice and partially prepared NAM205 when an address is known. When an address is unknown, collect actual search efforts for NAM207; explain that its filed-application statement must be true before signing. Publication awaits a judicial order and newspaper proof. Multiple other parents need further implementation.

FEE102 is a clearly identified DOCX adaptation of the current court form, with legal-aid, listed-benefit, low-income, and fuller financial paths. Preserve every numbered declaration and gather household, income, debt, money, expenses, and property information when required. Use current court instructions for poverty guidelines rather than retaining the LHI interview’s dated dollar amounts. Keep the confidential affidavit out of the combined public filing bundle. Inmates receive FEE201 guidance; that distinct financial affidavit is still a separate manual step.

The court’s NAM101/NAM106 and conditional service, publication, and fee-waiver instructions are downloadable public static documents. Court administration supplies hearing details; the actual server signs proof of service. Legal acceptance, local court requirements, and unusual workflows still need client review.

## Local court requirements and rendering corrections

The downloaded LHI adult packet contains NAM102, NAM103, NAM107, court instructions, and next steps. Its fee and browser advice is dated; use current court guidance instead. The current Hennepin supplement (Rev 12/24) requests a separate proposed order for each person changing their name. Generate those copies with individual captions and relief, retaining the joint application's family facts and leaving the entire judicial section untouched. Include the official supplement. A known-address Hennepin notice still requires actual certified mailing, a mailing affidavit, and receipts; NAM205 is personal-service proof, not mailing proof.

Missing a parent from a birth certificate does not alone establish a notice exception. Require confirmation of the supplemental guide's marriage/attempted-marriage, Recognition of Parentage, and parentage-order conditions before using the unidentified-parent route. This is a conservative development guard for all counties, not a determination that a court has waived notice.

Include the current blank FEE201 for the inmate fee-waiver route, with eligibility/account-record guidance. It is intentionally a manual financial affidavit, not a filled FEE102 substitution. Visual review found a narrow table cell wrapping the state name and duplicate checkbox list bullets in NAM107. Put state/county text in the wide caption cells and remove duplicate list bullets only from replaced checkbox paragraphs. Preserve numbered findings and the court-only order section.

## Style and scope presentation

Display the adult/minor distinction, five-row limits, and single-other-parent boundary before asking for detailed information. Follow the published adult-name-change interview's pattern of explicit eligibility/preparation metadata. Keep Minnesota legal rules grounded in the Minnesota sources. Use semantic headings in the newly authored fee affidavit/checklist, smaller heading spacing to avoid an orphaned instruction page, and a live printable LawHelpMN hyperlink. Keep official form names and required declarations even when the style checker suggests simpler words.

Separate NAM205's title from the children's current-name field: the original tabbed line does not accommodate several full names reliably. Add a regression asserting that title and names remain distinct. Render parental samples with actual synthetic children instead of a childless default context.

The preview renderer deletes each previous PDF before conversion and requires a new output for every template. A stale preview must never make a failed LibreOffice conversion appear successful. The independent workspace verifier also uses fresh temporary outputs. New packet tests and provenance records distinguish the full browser run from focused verification after final presentation changes.

## Plain-language and question-style review — 2026-10-04

Reviewed screens against plain-language guidance and the Assembly Line "Writing good questions" guide. Weaver-generated labels ("Change the first name of your first listed child to:", "One or more parties…") became short field labels. Statement-style yes/no labels became questions. The intro screen is shorter, and the interview's limits moved into a collapsible section.

Answer for the user where possible. The judicial district is derived from the filing county using the courts table, and the filing county defaults to the user's county (both are dropdowns). The names of included children are computed from the children who request new names, so the user does not retype them. The other parent's address question is on the same screen as the parent's name. This removes the earlier validation that told users to "go back" and enter an address.

Every referral screen now offers a button to edit the answer that triggered it. The divorce-exception screen used to say "go back and turn off the exception" but offered only Restart. The review screen shows answers and follows the interview order. The unused e-signature preview screen, which said the form would be signed "on the next page", was removed. The fee-waiver screens use bulleted lists instead of long sentences.

## Shared LawHelpMN branding — 2026-10-05

Reference the installed `docassemble.LawHelpMNBranding` package directly: `LawHelpMNBranding_custom.css` supplies the Bootstrap theme and `LawHelpMN2x_002_resized.png` supplies the full logo. Set the AssemblyLine organization title and homepage to LawHelpMN. The branding package must be installed on the server. No branding assets or CSS adapters are copied into the interviews.

## Shared theme entrypoint — 2026-10-05

The LemmaLegalConsulting fork now provides `docassemble.LawHelpMNBranding:theme.yml`. Include it after AssemblyLine instead of repeating the theme, logo, and organization settings in each interview. Install the Lemma fork (version 0.0.2 or later) on the server. This supersedes the direct configuration above and matches the shared theme include pattern used by LITLabTheme.
