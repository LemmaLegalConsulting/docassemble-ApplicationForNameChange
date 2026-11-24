# Name Change: prioritized review

Updated 2026-11-24 after the financial/family-validation implementation. See [PACKET_SCOPE.md](PACKET_SCOPE.md) for generated forms, primary sources, the completed LHI route, and explicit boundaries. Passing tests does not establish court acceptance or complete LHI parity.

## Implemented

Core NAM102/NAM103/NAM107 packet, conditional felony/inmate/parental forms, current fee-waiver content, court instructions, Hennepin individual orders, and a conditional checklist. Added age/residency/no-relief/referral guards, verified dissolution-exception handling, per-person release data, actual parent-search facts, and fee-waiver branching. Confidential FEE102 is excluded from the combined public bundle. Template labels and rendering are checked. LawHelpMN remains linked throughout.

Financial/family validation now includes structured household members, expense categories and totals, property values/debts/equity, a sourced annual poverty-guideline comparison with a stale-year fallback, a review for inconsistent monthly/yearly income, complete requested child names, and an editable referral for adults in the minor-child list. Review links expose individual financial sections. New browser tests cover financial edits, contradictory household relationships, child-name/age corrections, and county/district/order recalculation. See DEVELOPMENT.md for the reproducible Docker runner and live browser view.

## Remaining priorities

1. **P0 — Client/court review of packet content and local acceptance.** Confirm the FEE102 content adaptation, Hennepin individual-order treatment, birth-record requests, service requirements, the dissolution exception, and unidentified-parent conditions. Compare representative family/felony/fee-waiver LHI outputs or source ZIPs. Obtain the correct Hennepin mailing affidavit and generate it without fabricating service facts.

2. **P1 — Broader packet configurations.** Add multiple non-applicant parents, automatic overflow sheets, additional minor signature sheets, and more than five child/felony rows. Decide whether to implement the separate minor-only NAM202 packet and existing-case NAM113/114 workflow. Finish the distinct FEE201 financial interview; currently the official blank form is included for manual completion.

3. **P1 — Remaining financial and family validation.** Confirm whether the requester is the relevant parent/guardian and how to handle included family members seeking relief beyond a name change. Review household and income definitions with the court, including separated spouses, older dependents, variable income, and gross-versus-take-home figures. Keep guideline data current each year. Broader notice-route and family re-addition coverage remains in priority 4.

4. **P1 — Broader editing and document review.** Exercise changing counties and notice routes, removing/re-adding spouses or children, multiple felony recipients, long/Unicode names, and very long declarations. Inspect real signature space, pagination, mobile/keyboard navigation, and tagged-PDF reading order. Source Word forms contain inherited layout/headings warnings. Investigate intermittent localhost “page expired” responses observed in fast browser runs; preserve failed artifacts and rerun affected scenarios independently rather than suppressing the error.

5. **P2 — Plain language, accessibility, and translations.** Review remaining generated terminology and substantive birth-record labels against the Assembly Line style guide with client input. Improve template semantics without changing required legal declarations. Confirm public publishing metadata and support/contact text before deployment.
