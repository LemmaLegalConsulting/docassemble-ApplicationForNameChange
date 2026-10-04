# Name Change: prioritized improvements

Reviewed 2026-10-04. Static source/template review only; no completed browser interview has been verified. Synthetic template rendering is recorded in `validation/template-verification.json`. Passing DAYamlChecker does not establish production readiness.

## P0 — complete before a pilot release

1. **Fix spouse and child branching.** In `data/questions/Application_for_name_change.yml`, the interview order gathers spouse details before `not_married`, then accesses five children's birthdates unconditionally before `no_minor_children`. Branch on household and application scope before gathering people. Test unmarried/no children and each supported family combination without forcing extra people.
2. **Finish semantic PDF mapping QA.** The setup pass split the second child’s last-name widget out of the third child’s field and corrected the corresponding YAML mapping. All 152 logical PDF fields now have exactly one mapping. Confirm checkbox exports, spouse inclusion values, and every repeated field using complete interview scenarios; static coverage does not prove correct answers.
3. **Replace placeholder next steps.** `Application_for_name_change_next_steps.docx` contains “doing XYZ,” generic other-party delivery/waiting text, and unfinished sections. Obtain client-approved filing, signatures, service/notice, hearing, and follow-up instructions for the supported routes.
4. **Supply or replace the missing logo asset.** `al_logo` points to `MNfavicon-96x96.png`, but the package's static directory contains only a README. Check branding and the first interview screen on the deployment server.

## P1 — functional and document QA

5. Add conditional fields for interpreter language, birth-record changes, spouse/children changes, non-applicant parent, criminal history, and property interests. Several follow-ups are currently displayed regardless of the preceding answer.
6. Revisit five hard-coded children/offense slots and very short name limits (including 10–11 characters for requested names). Agree supported limits, overflow behavior, and excluded cases; avoid silently dropping data.
7. Make the review screen branch-aware so visiting it does not ask irrelevant questions or recreate omitted people. Test changing an earlier yes answer to no.
8. Validate the current source form and client-approved eligibility, birth-record/confidentiality options, and exceptional routes. Identify additional forms the client expects; scope them explicitly rather than implying the application alone is a complete packet.
9. Populate publishing metadata: Minnesota jurisdiction, eligibility, prerequisites, and approved topic tags. Check dependency installation and the output bundle/addenda.

## P2 — polish

10. Address saved style/accessibility findings, including dense screens, long labels, heading levels in the DOCX, document title metadata, and plain language. Keep legally significant wording subject to client review.

## Acceptance scenarios for the next development phase

- Applicant alone; spouse excluded/included; no children, one child, and the agreed maximum; more-than-limit handling.
- Every supported birth-record, confidentiality, parent, criminal-history, and property branch.
- Long answers and overflow; review/edit/re-download; distinguish every person's PDF fields.
- Print-ready output and client-approved next steps.

Planning range: **14–20 hours**, assuming existing form reuse and one consolidated client review round.
