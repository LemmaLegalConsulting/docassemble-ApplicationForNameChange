# ALDashboard static draft reviewed against interview order and the existing regression suite.
@e2e
Feature: Complete a representative interview

  Scenario: Robin applies alone with no criminal history
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | all_applicants_resident_six_months | True | |
      | request_fee_waiver | False | |
      | users[0].release_other_names | Robin Former | |
      | users[0].release_sex | Female | |
      | users[0].release_race | White | |
      | spouses[0].release_other_names | Jamie Former | |
      | spouses[0].release_sex | Male | |
      | spouses[0].release_race | White | |
      | children[0].release_other_names | | |
      | children[0].release_sex | Female | |
      | children[0].release_race | White | |
      | children[1].release_other_names | | |
      | children[1].release_sex | Male | |
      | children[1].release_race | White | |
      | children[2].release_other_names | | |
      | children[2].release_sex | Female | |
      | children[2].release_race | White | |
      | parent_address_known | True | |
      | unidentified_parent_conditions_confirmed | True | |
      | court_administrator_address | 15 West Kellogg Boulevard | |
      | court_administrator_city_state_zip | St. Paul, MN 55102 | |
      | felony_notices[0].person_index | 0 | |
      | felony_notices[0].kind | minnesota | |
      | felony_notices[0].authority | Ramsey County, Minnesota | |
      | users[0].name.first | Robin | |
      | users[0].name.last | Original | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | users[0].address.county | Ramsey | |
      | users[0].phone_number | 6125550100 | |
      | users[0].email | robin@example.com | |
      | interpreter_request | False | |
      | district_court_county | Ramsey | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | True | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
