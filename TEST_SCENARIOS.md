# Narrative scenarios and acceptance coverage

All people and addresses are synthetic. Story tables describe the current implementation; passing them does not establish legal completeness or LHI parity. See `validation/` for actual execution results, not an assumed pass.

| Tag | Persona / scenario | Purpose and expectation | Destination |
| --- | --- | --- | --- |
| `adult_no_family` | Robin applies alone with no criminal history | Only applicable people and requests should be gathered; entered data and overflow must survive document assembly. | `download Application_for_name_change` |
| `spouse_not_applying` | Robin lists a spouse who is not applying | Only applicable people and requests should be gathered; entered data and overflow must survive document assembly. | `download Application_for_name_change` |
| `three_children` | Robin includes three children with distinct surnames | Only applicable people and requests should be gathered; entered data and overflow must survive document assembly. | `download Application_for_name_change` |
| `birth_record_and_history` | Robin requests birth-record relief and discloses a felony | Only applicable people and requests should be gathered; entered data and overflow must survive document assembly. | `download Application_for_name_change` |
| `land_and_long_names` | Alexandria has long names and a lengthy property description | Only applicable people and requests should be gathered; entered data and overflow must survive document assembly. | `download Application_for_name_change` |

## Additional family and language scenarios

- `spouse_applying`: Robin and spouse Jamie both request new names. The story gathers spouse contact information and checks that Jamie’s requested name appears in the assembled application.
- `children_not_applying`: Robin lists a minor child for family disclosure but does not include the child in the name-change request. The story checks that the child is listed without demanding a new child name.
- `interpreter_needed`: Robin requests a Hmong interpreter. The story checks the selected language in the generated application.

## Additional review

Inspect long-answer pagination, signatures, mobile/keyboard navigation, and PDF reading order. Compare output with source forms and client-approved examples. Test limitations that require manual extra sheets as limitations, not as automated completion.

- `remove_children`: Robin removes children after completing the application. Edit existing answers and assert the changed document or help screen.

## Testing gaps to preserve for client review

No live LHI parity comparison, production deployment, full screen-reader audit, or client legal-content acceptance is claimed. See IMPROVEMENTS.md for the ordered remaining work. Extra-sheet workflows must be reviewed as manual steps.
