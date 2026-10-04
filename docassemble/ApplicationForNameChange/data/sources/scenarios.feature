Feature: Narrative regression scenarios

  @adult_no_family
  Scenario: Robin applies alone with no criminal history
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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

  @spouse_not_applying
  Scenario: Robin lists a spouse who is not applying
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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

  @three_children
  Scenario: Robin includes three children with distinct surnames
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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

  @birth_record_and_history
  Scenario: Robin requests birth-record relief and discloses a felony
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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

  @land_and_long_names
  Scenario: Alexandria has long names and a lengthy property description
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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


  @remove_children
  Scenario: Robin removes children after completing the application
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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


  @spouse_applying
  Scenario: Robin and Jamie both request new names
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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

  @children_not_applying
  Scenario: Robin lists a child who is not applying
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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

  @interpreter_needed
  Scenario: Robin requests a Hmong interpreter
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
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
