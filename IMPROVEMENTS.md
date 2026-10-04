# Name Change: prioritized review

Updated 2026-10-04 after implementation and local testing. See [TEST_SCENARIOS.md](TEST_SCENARIOS.md), [DECISIONS.md](DECISIONS.md), and saved `validation/` reports. Automated passes do not establish legal acceptance or LHI parity.

## Implemented

Repaired conditional spouse/child gathering and review, mutually exclusive history checkboxes, hidden-output guards, the missing county question, single-spouse gathering, short name limits, city/state/ZIP mapping, and the child-2 PDF field. Replaced unrelated next-steps boilerplate. Matching LawHelpMN help is linked in metadata, introduction, downloads, and printable instructions. Template labels are inventoried.

## Remaining priorities

1. **P0 — Confirm the current court packet and legal scope.** The supplied NAM102 is Rev 7/23. Compare with the current court packet, decide which companion forms must be generated, and confirm residency, age, notice, criminal-history, birth-record, and signature rules. This implementation prepares an application, not a complete filing packet.

2. **P0 — Prevent requests with no substantive relief selected.** The current form lets the user decline individual requests. Add an agreed final check that at least one supported change is requested, including spouse/child-only routes. Decide how to handle special procedures and eligibility before publication.

3. **P1 — Automate additional sheets and more family configurations.** Five child-name rows and five felony rows remain paper-form limits. More children receive an extra-sheet instruction. Multiple non-applicant parents and children aged 14 or older need fuller signature/notice handling. Avoid treating the manual instructions as automatic completion.

4. **P1 — Expand review editing and document layout checks.** Check spouse contact/name edits, removing and re-adding children, Unicode and very long names, addresses, and overflow. Existing tests check distinct child-2/child-3 surnames and representative long-text output; inspect all boxes and addenda visually.

5. **P2 — Finish style and translation cleanup.** Three style warnings remain: a legacy variable name that is also tied to the PDF contract, an overflow label in code, and a long birth-record confidentiality label. Preserve substantive meaning while simplifying and making labels translatable. Review publishing metadata and dependencies.
