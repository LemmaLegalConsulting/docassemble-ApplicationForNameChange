Feature: Narrative regression scenarios

  @adult_no_family
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
      | judicial_district | Second | |
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

  @spouse_not_applying
  Scenario: Robin lists a spouse who is not applying
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | False | |
      | no_minor_children | True | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | application_includes_spouse | no_includes_spouse | |
      | spouses[0].name.first | Jamie | |
      | spouses[0].name.last | Spouse | |
      | spouses[0].birthdate | 01/02/1970 | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"

  @three_children
  Scenario: Robin includes three children with distinct surnames
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | minor_children_included_names | First Child, Second SurnameTwo, Third SurnameThree | |
      | request_childrens_name_change | True | |
      | parents_nonapplicant_unknown | True | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2013 | |
      | children[1].name.first | Second | |
      | children[1].name.last | SurnameTwo | |
      | children[1].birthdate | 01/02/2014 | |
      | children[2].name.first | Third | |
      | children[2].name.last | SurnameThree | |
      | children[2].birthdate | 01/02/2015 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | children2_name_first_change | Second | |
      | children2_name_last_change | Newname | |
      | children3_name_first_change | Third | |
      | children3_name_last_change | Newname | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "SurnameTwo"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "SurnameThree"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameTwo"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameThree"

  @birth_record_and_history
  Scenario: Robin requests birth-record relief and discloses a felony
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | True | |
      | request_sex_change_on_birth_record | True | |
      | replacement_birth_record | True | |
      | not_married | True | |
      | no_minor_children | True | |
      | parties_have_criminal_history | True | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | users1_name_first_change_birth_record | Robin | |
      | users1_name_last_change_birth_record | Newname | |
      | sex_current | F | |
      | sex_change | X | |
      | keep_former_name_confidential | True | |
      | keep_former_sex_confidential | True | |
      | criminal_history | Robin Original: one disclosed felony. | |
      | parties_with_criminal_history | True | |
      | felony_count | 1 | |
      | party1_with_offense | Robin Original | |
      | party1_name_of_offense | Example offense | |
      | party1_date_of_offense | 01/02/2005 | |
      | party1_state_of_offense | Minnesota | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"

  @land_and_long_names
  Scenario: Alexandria has long names and a lengthy property description
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Alexandria-Cassandra | |
      | users1_name_last_change | Rivera-Montgomery-Washington | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | True | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | name_of_person_and_description_of_person_with_claim_interest_or_lien | Robin Original. Synthetic property description for overflow testing. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County. Lot 1, Block 2, Example Addition, Ramsey County.  | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"

  @remove_children
  Scenario: Robin removes children after completing the application
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | minor_children_included_names | First Child, Second SurnameTwo, Third SurnameThree | |
      | request_childrens_name_change | True | |
      | parents_nonapplicant_unknown | True | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2013 | |
      | children[1].name.first | Second | |
      | children[1].name.last | SurnameTwo | |
      | children[1].birthdate | 01/02/2014 | |
      | children[2].name.first | Third | |
      | children[2].name.last | SurnameThree | |
      | children[2].birthdate | 01/02/2015 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | children2_name_first_change | Second | |
      | children2_name_last_change | Newname | |
      | children3_name_first_change | Third | |
      | children3_name_last_change | Newname | |
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "Minor children"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | no_minor_children | True | |
    When I tap to continue
    Then the question id should be "download Application_for_name_change"
    Then I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should not contain "SurnameTwo"
    And the downloaded PDF "Application_for_name_change.pdf" should not contain "SurnameThree"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And the downloaded PDF "criminal_history_releases.pdf" should not contain "SurnameTwo"

  @spouse_applying
  Scenario: Robin and Jamie both request new names
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | False | |
      | no_minor_children | True | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | application_includes_spouse | yes_includes_spouse | |
      | spouses[0].name.first | Jamie | |
      | spouses[0].name.last | Spouse | |
      | spouses[0].birthdate | 02/03/1972 | |
      | request_applicant_spouse_name_change | True | |
      | spouses_name_first_change | Jamie | |
      | spouses_name_last_change | Newname | |
      | spouses[0].address.address | 456 Sample Avenue | |
      | spouses[0].address.city | St. Paul | |
      | spouses[0].address.state | MN | |
      | spouses[0].address.zip | 55101 | |
      | spouses[0].phone_number | 6515550123 | |
      | spouses[0].email | jamie@example.com | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Jamie"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "jamie@example.com"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"

  @children_not_applying
  Scenario: Robin lists a child who is not applying
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 1 | |
      | children[0].name.first | Casey | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 03/04/2014 | |
      | minor_children_listed_not_included_in_application | minor_children_included_no | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Casey"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"

  @interpreter_needed
  Scenario: Robin requests a Hmong interpreter
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
      | interpreter_request | True | |
      | district_court_county | Ramsey | |
      | judicial_district | Second | |
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
      | interpreter_language | Hmong | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Hmong"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"

  @fee_benefits
  Scenario: Robin receives SNAP and requests a fee waiver
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | all_applicants_resident_six_months | True | |
      | request_fee_waiver | True | |
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
      | judicial_district | Second | |
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
      | fee_legal_services | False | |
      | fee_public_assistance | listed | |
      | fee_benefits["SNAP"] | True | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And I download "fee_waiver_affidavit.pdf"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "SNAP"

  @fee_legal_aid
  Scenario: Robin has a legal aid lawyer
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | all_applicants_resident_six_months | True | |
      | request_fee_waiver | True | |
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
      | judicial_district | Second | |
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
      | fee_legal_services | True | |
      | fee_lawyer_name | Counsel Example | |
      | fee_lawyer_program | Legal Aid | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And I download "fee_waiver_affidavit.pdf"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Counsel Example"

  @fee_full_financial
  Scenario: Robin explains expenses and assets for a fee waiver
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | all_applicants_resident_six_months | True | |
      | request_fee_waiver | True | |
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
      | judicial_district | Second | |
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
      | fee_legal_services | False | |
      | fee_public_assistance | none | |
      | fee_household_size | 1 | |
      | fee_household_members | None | |
      | fee_income_sources | Job | |
      | fee_monthly_income | 3000 | |
      | fee_income_is_average | False | |
      | fee_other_household_income | None | |
      | fee_yearly_income | 36000 | |
      | fee_below_poverty_guideline | False | |
      | fee_expenses | Rent $2000; utilities $100; food $400; car payments $0; car insurance $0; spousal support $0; child support $0; childcare $0; medical insurance $100; cell phone $50; other expenses $0 | |
      | fee_debt | 1000 | |
      | fee_cash | 5 | |
      | fee_accounts | 10 | |
      | fee_assets | Vehicle: none; home: none; other real estate: none; other personal property: none | |
      | fee_other_reasons | Medical emergency | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And I download "fee_waiver_affidavit.pdf"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Medical emergency"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "36000.00"

  @inmate_packet
  Scenario: Robin requests a first name change during confinement
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
      | judicial_district | Second | |
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
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | True | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | inmate_prior_name_change_request | False | |
      | inmate_name_change_reason | Match my identity | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And I download "inmate_name_change_affidavit.pdf"
    And the downloaded PDF "inmate_name_change_affidavit.pdf" should contain "Match my identity"

  @parent_known_address
  Scenario: Robin prepares notice for the children’s other parent
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | minor_children_included_names | First Child, Second SurnameTwo, Third SurnameThree | |
      | request_childrens_name_change | True | |
      | parents_nonapplicant_unknown | False | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2013 | |
      | children[1].name.first | Second | |
      | children[1].name.last | SurnameTwo | |
      | children[1].birthdate | 01/02/2014 | |
      | children[2].name.first | Third | |
      | children[2].name.last | SurnameThree | |
      | children[2].birthdate | 01/02/2015 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | children2_name_first_change | Second | |
      | children2_name_last_change | Newname | |
      | children3_name_first_change | Third | |
      | children3_name_last_change | Newname | |
      | parents_nonapplicant_name_first | Other | |
      | parents_nonapplicant_name_last | Parent | |
      | parents_nonapplicant_address_address | 456 Sample Avenue | |
      | parents_nonapplicant_city_state_zip | St. Paul, MN 55101 | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "SurnameTwo"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "SurnameThree"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameTwo"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameThree"
    And I download "parental_hearing_notice.pdf"
    And the downloaded PDF "parental_hearing_notice.pdf" should contain "Other Parent"
    And I download "parental_personal_service.pdf"
    And the downloaded PDF "parental_personal_service.pdf" should contain "Other Parent"

  @parent_unknown_address
  Scenario: Robin cannot find the children’s other parent
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
      | parent_address_known | False | |
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | minor_children_included_names | First Child, Second SurnameTwo, Third SurnameThree | |
      | request_childrens_name_change | True | |
      | parents_nonapplicant_unknown | False | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2013 | |
      | children[1].name.first | Second | |
      | children[1].name.last | SurnameTwo | |
      | children[1].birthdate | 01/02/2014 | |
      | children[2].name.first | Third | |
      | children[2].name.last | SurnameThree | |
      | children[2].birthdate | 01/02/2015 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | children2_name_first_change | Second | |
      | children2_name_last_change | Newname | |
      | children3_name_first_change | Third | |
      | children3_name_last_change | Newname | |
      | parents_nonapplicant_name_first | Other | |
      | parents_nonapplicant_name_last | Parent | |
      | parent_last_location | St. Paul | |
      | parent_last_employment | Unknown | |
      | parent_relatives | Relative at sample address | |
      | parent_search_efforts | Called the relative and searched for an address | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "SurnameTwo"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "SurnameThree"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameTwo"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameThree"
    And I download "parental_publication_request.pdf"
    And the downloaded PDF "parental_publication_request.pdf" should contain "Called the relative"

  @federal_felony_notice
  Scenario: Robin needs notice for a federal conviction
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
      | felony_notices[0].kind | federal | |
      | felony_notices[0].authority | District of Minnesota | |
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | True | |
      | request_sex_change_on_birth_record | True | |
      | replacement_birth_record | True | |
      | not_married | True | |
      | no_minor_children | True | |
      | parties_have_criminal_history | True | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | users1_name_first_change_birth_record | Robin | |
      | users1_name_last_change_birth_record | Newname | |
      | sex_current | F | |
      | sex_change | X | |
      | keep_former_name_confidential | True | |
      | keep_former_sex_confidential | True | |
      | criminal_history | Robin Original: one disclosed felony. | |
      | parties_with_criminal_history | True | |
      | felony_count | 1 | |
      | party1_with_offense | Robin Original | |
      | party1_name_of_offense | Example offense | |
      | party1_date_of_offense | 01/02/2005 | |
      | party1_state_of_offense | Minnesota | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Robin Former"
    And I download "felony_name_change_notices.pdf"
    And the downloaded PDF "felony_name_change_notices.pdf" should contain "District of Minnesota"
    And the downloaded PDF "felony_name_change_notices.pdf" should contain "Robin Newname"

  @divorce_exception
  Scenario: Robin returns to a birth name after divorce
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
      | judicial_district | Second | |
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
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | True | |
      | divorce_exception_confirmed | True | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information"
    And I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Robin"
    And I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    Then I should not see the phrase "Criminal history releases (NAM103)"


  @primary_minor
  Scenario: Seventeen-year-old Robin gets the minor-packet referral
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "adult applicant help" with this data:
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
      | users[0].birthdate | 01/02/2009 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | users[0].address.county | Ramsey | |
      | users[0].phone_number | 6125550100 | |
      | users[0].email | robin@example.com | |
      | interpreter_request | False | |
      | district_court_county | Ramsey | |
      | judicial_district | Second | |
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
    Then the question id should be "adult applicant help"

  @residency_failure
  Scenario: Recent arrival Robin checks the residency requirement
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "residency help" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | all_applicants_resident_six_months | False | |
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
      | judicial_district | Second | |
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
    Then the question id should be "residency help"

  @no_relief
  Scenario: Robin selects no changes and gets an explanation
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "no relief selected" with this data:
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | False | |
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
    Then the question id should be "no relief selected"

  @inmate_repeat
  Scenario: Robin made a previous request during this confinement
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "inmate repeat request help" with this data:
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
      | judicial_district | Second | |
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
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | True | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | inmate_prior_name_change_request | True | |
    Then the question id should be "inmate repeat request help"

  @minor_only
  Scenario: Robin only wants changes for children
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "minor only packet help" with this data:
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | False | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | minor_children_included_names | First Child, Second SurnameTwo, Third SurnameThree | |
      | request_childrens_name_change | True | |
      | parents_nonapplicant_unknown | True | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2013 | |
      | children[1].name.first | Second | |
      | children[1].name.last | SurnameTwo | |
      | children[1].birthdate | 01/02/2014 | |
      | children[2].name.first | Third | |
      | children[2].name.last | SurnameThree | |
      | children[2].birthdate | 01/02/2015 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | children2_name_first_change | Second | |
      | children2_name_last_change | Newname | |
      | children3_name_first_change | Third | |
      | children3_name_last_change | Newname | |
    Then the question id should be "minor only packet help"

  @parent_not_exempt
  Scenario: Robin cannot confirm the unknown-parent exception
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "unidentified parent help" with this data:
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
      | unidentified_parent_conditions_confirmed | False | |
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | minor_children_included_names | First Child, Second SurnameTwo, Third SurnameThree | |
      | request_childrens_name_change | True | |
      | parents_nonapplicant_unknown | True | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2013 | |
      | children[1].name.first | Second | |
      | children[1].name.last | SurnameTwo | |
      | children[1].birthdate | 01/02/2014 | |
      | children[2].name.first | Third | |
      | children[2].name.last | SurnameThree | |
      | children[2].birthdate | 01/02/2015 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | children2_name_first_change | Second | |
      | children2_name_last_change | Newname | |
      | children3_name_first_change | Third | |
      | children3_name_last_change | Newname | |
    Then the question id should be "unidentified parent help"

  @release_age_boundary
  Scenario: Children just below and at age ten get the correct release coverage
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
      | judicial_district | Second | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | True | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | minor_children_included_names | First Child, Second SurnameTwo, Third SurnameThree | |
      | request_childrens_name_change | True | |
      | parents_nonapplicant_unknown | True | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 10/05/2016 | |
      | children[1].name.first | Second | |
      | children[1].name.last | SurnameTwo | |
      | children[1].birthdate | 10/04/2016 | |
      | children[2].name.first | Third | |
      | children[2].name.last | SurnameThree | |
      | children[2].birthdate | 01/02/2015 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | children2_name_first_change | Second | |
      | children2_name_last_change | Newname | |
      | children3_name_first_change | Third | |
      | children3_name_last_change | Newname | |
    Then I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should not contain "SurnameOne"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameTwo"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameThree"

  @hennepin_joint
  Scenario: Robin and Jamie prepare separate Hennepin orders
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
      | users[0].address.city | Minneapolis | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55487 | |
      | users[0].address.county | Hennepin | |
      | users[0].phone_number | 6125550100 | |
      | users[0].email | robin@example.com | |
      | interpreter_request | False | |
      | district_court_county | Hennepin | |
      | judicial_district | Fourth | |
      | request_for_applicant_name_change | True | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | False | |
      | request_sex_change_on_birth_record | False | |
      | replacement_birth_record | False | |
      | not_married | False | |
      | no_minor_children | True | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | application_includes_spouse | yes_includes_spouse | |
      | spouses[0].name.first | Jamie | |
      | spouses[0].name.last | Spouse | |
      | spouses[0].birthdate | 02/03/1972 | |
      | request_applicant_spouse_name_change | True | |
      | spouses_name_first_change | Jamie | |
      | spouses_name_last_change | Newname | |
      | spouses[0].address.address | 456 Sample Avenue | |
      | spouses[0].address.city | St. Paul | |
      | spouses[0].address.state | MN | |
      | spouses[0].address.zip | 55101 | |
      | spouses[0].phone_number | 6515550123 | |
      | spouses[0].email | jamie@example.com | |
    Then I download "proposed_name_change_order.pdf"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Robin"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Jamie"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "IT IS ORDERED that:" exactly 2 times
    And I should see the phrase "Hennepin supplemental instructions"

  @fee_below_guideline
  Scenario: Robin uses the below-guideline financial route
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | all_applicants_resident_six_months | True | |
      | request_fee_waiver | True | |
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
      | judicial_district | Second | |
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
      | fee_legal_services | False | |
      | fee_public_assistance | none | |
      | fee_household_size | 1 | |
      | fee_household_members | None | |
      | fee_income_sources | Job | |
      | fee_monthly_income | 500 | |
      | fee_income_is_average | False | |
      | fee_other_household_income | None | |
      | fee_yearly_income | 6000 | |
      | fee_below_poverty_guideline | True | |
      | fee_expenses | Rent $2000; utilities $100; food $400; car payments $0; car insurance $0; spousal support $0; child support $0; childcare $0; medical insurance $100; cell phone $50; other expenses $0 | |
      | fee_debt | 1000 | |
      | fee_cash | 5 | |
      | fee_accounts | 10 | |
      | fee_assets | Vehicle: none; home: none; other real estate: none; other personal property: none | |
      | fee_other_reasons | Medical emergency | |
    Then I download "fee_waiver_affidavit.pdf"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "6000.00"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should not contain "Rent $2000"

  @fee_remove
  Scenario: Robin removes the fee waiver after entering financial details
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | all_applicants_resident_six_months | True | |
      | request_fee_waiver | True | |
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
      | judicial_district | Second | |
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
      | fee_legal_services | False | |
      | fee_public_assistance | none | |
      | fee_household_size | 1 | |
      | fee_household_members | None | |
      | fee_income_sources | Job | |
      | fee_monthly_income | 3000 | |
      | fee_income_is_average | False | |
      | fee_other_household_income | None | |
      | fee_yearly_income | 36000 | |
      | fee_below_poverty_guideline | False | |
      | fee_expenses | Rent $2000; utilities $100; food $400; car payments $0; car insurance $0; spousal support $0; child support $0; childcare $0; medical insurance $100; cell phone $50; other expenses $0 | |
      | fee_debt | 1000 | |
      | fee_cash | 5 | |
      | fee_accounts | 10 | |
      | fee_assets | Vehicle: none; home: none; other real estate: none; other personal property: none | |
      | fee_other_reasons | Medical emergency | |
    When I follow the review link containing "Edit packet information"
    And I follow the review link containing "Fee waiver"
    And I get to "review packet choices" with this data:
      | var | value | trigger |
      | request_fee_waiver | False | |
    When I tap to continue
    Then the question id should be "download Application_for_name_change"
    And I should not see the phrase "Fee waiver affidavit (FEE102)"
    And I download "Application_for_name_change_next_steps.pdf"
    And the downloaded PDF "Application_for_name_change_next_steps.pdf" should not contain "Review and sign the confidential"

