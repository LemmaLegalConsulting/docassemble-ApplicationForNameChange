# Name change packet scope and comparison

Reviewed October 4, 2026. This is a development implementation for an adult application, including a spouse and up to five children requesting name changes. It is a packet preparation tool; court approval, filing, execution, and service still happen separately.

## What the packet generates

| Form or document | When included | Remaining real-world action |
| --- | --- | --- |
| NAM102 application, current court revision 7/23 | Supported adult route | Review and sign; included spouse and minors 14+ also sign |
| NAM103 criminal-history release | Covered people age 10+; omitted for verified sole-adult dissolution exception | Sign; court/BCA completes verification |
| NAM107 proposed order | All supported routes; separate copies for each requesting person in Hennepin | Court completes hearing/service findings, judicial relief, and signature |
| NAM104 felony notice | Each disclosed felony, with selected person and jurisdiction | Serve the authority and application; federal/out-of-state cases also require Attorney General notice; provide proof of service |
| NAM105 inmate affidavit | First request during this confinement | Review the confinement declaration and reason, then execute |
| Hearing notice and NAM205 personal-service affidavit | Included children with one identified other parent and known address | Obtain hearing details; actual server completes delivery facts and affidavit |
| Hearing notice and NAM207 publication request | Identified other parent with unknown address | File application before signing its declaration; judge decides alternative notice; newspaper supplies publication proof |
| FEE102 adaptation (current 07/24 content) | Non-inmate fee-waiver request | Review financial declarations, sign, attach proof, file confidentially |
| Official blank FEE201 | Inmate fee-waiver request | Check eligibility, fill financial affidavit, obtain correctional account records and authorization |
| NAM101, NAM106, conditional NAM204/NAM206/FEE101, Hennepin supplement | Applicable instructions | Follow current court and county requirements |
| Personalized next steps | All supported routes | Review the checklist with the forms |

FEE102 is a clearly labeled content adaptation, not a facsimile of the six-page court PDF. Financial details may expand. It is individually downloadable and excluded from the combined public court bundle. Other documents may also contain sensitive information; follow the court's filing classifications.

## LHI comparison actually performed

A synthetic adult walkthrough of [the replacement LHI interview, 5664](https://lawhelpinteractive.org/Interview/GenerateInterview/5664/engine) reached completion and downloaded its assembled Word packet. The route used an adult with no spouse, children, criminal history, property interests, or fee waiver. Qualification questions, birth-record choices, background-release information, the fee-waiver choice, and final assembly were inspected. The downloaded packet contains next steps, court instructions, NAM102, NAM103, and NAM107, confirming that application-only output was insufficient.

The LHI launch identifies a 2019 update. Its instructions include dated fee figures and Internet Explorer advice. Those statements were not carried forward. Detailed family/felony/fee-waiver branch parity has not been established. The original interview ZIPs and client-approved examples remain useful for that review. Raw browser pages/session URLs and synthetic LHI downloads stay outside Git.

## Current primary sources

- [Current adult packet](https://mncourts.gov/getforms/name-change/forms-packet-name-change), including NAM101 Rev 2/25.
- [All name change forms](https://mncourts.gov/getforms/name-change), including the NAM103/104/105/107/205/207 sources.
- [Hennepin supplement, Rev 12/24](https://mncourts.gov/_media/migration/courtforms/name-change/nam101-supp.pdf).
- [Fee waiver forms](https://mncourts.gov/getforms/fee-waiver), including current FEE102 and FEE201 Rev 07/24.
- [Matching LawHelpMN resource](https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information).

Archived originals, retrieval dates, URLs, and SHA-256 hashes are in `reference/court-originals/manifest.json`. Every automated template's labels are inventoried separately from official static downloads.

## Boundaries still needing work

- Minor-only applications use a separate court packet (NAM202); this adult interview provides a referral. Prior-granted-name birth-record replacement in an existing case (NAM113/114) is not implemented.
- Multiple non-applicant parents, more than five requested child names/felony rows, and additional minor signatures still need automated sheets and per-person notice handling. Current extra-sheet instructions are manual.
- Hennepin's certified-mail affidavit is not generated; NAM205 must not be used as mailing proof. Confirm the prepared individual orders and local service workflow with court/client reviewers.
- Publication newspaper notices/proof, felony proof of service, contested objections, and repeat inmate constitutional-right cases are not automated. Judicial approval and actual completed service cannot be prefilled.
- The unidentified-parent route uses a conservative confirmation of all four Hennepin guide conditions; local court review still controls notice.
- Poverty-guideline eligibility is a user confirmation against current court instructions, not an automated annually updated calculation. Financial disclosures currently use multiline descriptions for household members, expenses, and assets; richer structured entry and consistency checks are a review priority.

See [IMPROVEMENTS.md](IMPROVEMENTS.md) for the next work in priority order and [TEST_RESULTS.md](TEST_RESULTS.md) for actual checks.
