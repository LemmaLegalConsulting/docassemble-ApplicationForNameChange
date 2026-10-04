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
