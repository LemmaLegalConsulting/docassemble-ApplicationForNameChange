# Narrative scenarios and acceptance coverage

All people and addresses are synthetic. The ALKiln stories exercise the current packet implementation; they do not establish legal acceptance or complete LHI parity. Each story table specifies its inputs and actual expected destination. PDF assertions check assembled content, release coverage, conditional forms, review edits, and the number of Hennepin orders.

| Tag | Persona and expected behavior |
| --- | --- |
| `adult_no_family` | Robin applies alone with no criminal history |
| `spouse_not_applying` | Robin lists a spouse who is not applying |
| `three_children` | Robin includes three children with distinct surnames |
| `birth_record_and_history` | Robin requests birth-record relief and discloses a felony |
| `land_and_long_names` | Alexandria has long names and a lengthy property description |
| `remove_children` | Robin removes children after completing the application |
| `spouse_applying` | Robin and Jamie both request new names |
| `children_not_applying` | Robin lists a child who is not applying |
| `interpreter_needed` | Robin requests a Hmong interpreter |
| `fee_benefits` | Robin receives SNAP and requests a fee waiver |
| `fee_legal_aid` | Robin has a legal aid lawyer |
| `fee_full_financial` | Robin explains expenses and assets for a fee waiver |
| `inmate_packet` | Robin requests a first name change during confinement |
| `parent_known_address` | Robin prepares notice for the children’s other parent |
| `parent_unknown_address` | Robin cannot find the children’s other parent |
| `federal_felony_notice` | Robin needs notice for a federal conviction |
| `divorce_exception` | Robin returns to a birth name after divorce |
| `primary_minor` | Seventeen-year-old Robin gets the minor-packet referral |
| `residency_failure` | Recent arrival Robin checks the residency requirement |
| `no_relief` | Robin selects no changes and gets an explanation |
| `inmate_repeat` | Robin made a previous request during this confinement |
| `minor_only` | Robin only wants changes for children |
| `parent_not_exempt` | Robin cannot confirm the unknown-parent exception |
| `release_age_boundary` | Children just below and at age ten get the correct release coverage |
| `hennepin_joint` | Robin and Jamie prepare separate Hennepin orders |
| `fee_below_guideline` | Robin uses the below-guideline financial route |
| `fee_remove` | Robin removes the fee waiver after entering financial details |

The release-age boundary story is evaluated against October 4, 2026: one child is just below ten, one turns ten, and another is older. Refresh its synthetic dates when running on a later date. Negative routes assert the referral screen instead of treating a missing packet as a successful assembly.

Template tests separately check strict variable resolution, unchanged court-only order XML, multiple order copies, fee-waiver dormant-answer suppression, and the original child-2/child-3 PDF mapping regression. Visual samples are rendered outside Git. Actual execution summaries and retained failure explanations are in [TEST_RESULTS.md](TEST_RESULTS.md).

Still needing coverage: multiple other parents, automatic overflow/signature sheets, county and service-route edits, additional Unicode/long-answer combinations, full keyboard/screen-reader review, and client-approved legal examples. See [IMPROVEMENTS.md](IMPROVEMENTS.md).
