@editing_reliability
Feature: Editing an assembled family packet

  @notice_edits
  Scenario: Notice routes update after review edits
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
      | parent_address_known | True | |
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
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 1 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | request_childrens_name_change | True | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2013 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | parents_nonapplicant_name_first | Other | |
      | parents_nonapplicant_name_last | Parent | |
      | parents_nonapplicant_address_address | 456 Sample Avenue | |
      | parents_nonapplicant_city_state_zip | St. Paul, MN 55101 | |
      | children[0].name_change_parent_role | legal_parent | |
      | children[0].name_change_parent_basis | birth_certificate | |
      | children[0].name_change_authority_uncertain | False | |
      | children[0].name_change_resident_six_months | True | |
      | children[0].name_change_same_home | True | |
      | children[0].name_change_relief | name_only | |
      | children[0].name_change_other_parent_status | one_known | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | spouse_other_relief | False | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | True | |
    Then I download "parental_personal_service.pdf"
    And the downloaded PDF "parental_personal_service.pdf" should contain "Other Parent"
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "other parent:"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | parents_nonapplicant_name_first | Other | |
      | parents_nonapplicant_name_last | Parent | |
      | parent_address_known | False | |
    When I tap to continue
    And I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | parent_last_location | Last seen in Duluth in 2024 | |
      | parent_last_employment | Unknown | |
      | parent_relatives | Alex Parent, 10 Example Road | |
      | parent_search_efforts | Asked Alex in November; no current address | |
    Then I download "parental_publication_request.pdf"
    And the downloaded PDF "parental_publication_request.pdf" should contain "Last seen in Duluth in 2024"
    And the packet does not offer "parental_personal_service.pdf"
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "other parent:"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | parents_nonapplicant_name_first | Updated | |
      | parents_nonapplicant_name_last | Parent | |
      | parent_address_known | True | |
      | parents_nonapplicant_address_address | 789 Current Street | |
      | parents_nonapplicant_city_state_zip | Duluth, MN 55802 | |
    When I tap to continue
    And I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | children[0].name_change_shared_parent_confirmed | True | |
      | parent_service_method | personal_service | |
    When I archive the downloaded PDF "parental_personal_service.pdf" as "original-service.pdf"
    And I download "parental_personal_service.pdf"
    Then the downloaded PDF "parental_personal_service.pdf" should contain "Updated Parent"
    And the downloaded PDF "parental_personal_service.pdf" should not contain "Other Parent"
    And the packet does not offer "parental_publication_request.pdf"


    When I follow the review link containing "Edit answers"
    And I follow the review link containing "eligibility and notice"
    And I follow the review link containing "Other-parent situation"
    And I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | children[0].name_change_other_parent_status | none_unknown | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | parent_notice_exception_court_confirmed | True | |
    Then the packet does not offer "parental_hearing_notice.pdf"
    And the packet does not offer "parental_personal_service.pdf"
    And the packet does not offer "parental_publication_request.pdf"

  @family_edits
  Scenario: Removing and restoring family branches regenerates the packet
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
      | not_married | False | |
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | request_childrens_name_change | True | |
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
      | application_includes_spouse | yes_includes_spouse | |
      | spouses[0].name.first | Jamie | |
      | spouses[0].name.last | Originalspouse | |
      | spouses[0].birthdate | 02/03/1971 | |
      | request_applicant_spouse_name_change | True | |
      | spouses_name_first_change | Jamie | |
      | spouses_name_last_change | Newspouse | |
      | spouses[0].address.address | 123 Example Street | |
      | spouses[0].address.city | St. Paul | |
      | spouses[0].address.state | MN | |
      | spouses[0].address.zip | 55101 | |
      | spouses[0].phone_number | 6125550101 | |
      | spouses[0].email | jamie@example.com | |
      | children[0].name_change_parent_role | legal_parent | |
      | children[0].name_change_parent_basis | birth_certificate | |
      | children[0].name_change_authority_uncertain | False | |
      | children[0].name_change_resident_six_months | True | |
      | children[0].name_change_same_home | True | |
      | children[0].name_change_relief | name_only | |
      | children[0].name_change_other_parent_status | one_known | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | children[1].name_change_parent_role | legal_parent | |
      | children[1].name_change_parent_basis | birth_certificate | |
      | children[1].name_change_authority_uncertain | False | |
      | children[1].name_change_resident_six_months | True | |
      | children[1].name_change_same_home | True | |
      | children[1].name_change_relief | name_only | |
      | children[1].name_change_other_parent_status | one_known | |
      | children[1].name_change_shared_parent_confirmed | True | |
      | children[1].name_change_no_parent_on_certificate | True | |
      | children[1].name_change_no_marriage_presumption | True | |
      | children[1].name_change_no_recognition | True | |
      | children[1].name_change_no_parentage_order | True | |
      | children[2].name_change_parent_role | legal_parent | |
      | children[2].name_change_parent_basis | birth_certificate | |
      | children[2].name_change_authority_uncertain | False | |
      | children[2].name_change_resident_six_months | True | |
      | children[2].name_change_same_home | True | |
      | children[2].name_change_relief | name_only | |
      | children[2].name_change_other_parent_status | one_known | |
      | children[2].name_change_shared_parent_confirmed | True | |
      | children[2].name_change_no_parent_on_certificate | True | |
      | children[2].name_change_no_marriage_presumption | True | |
      | children[2].name_change_no_recognition | True | |
      | children[2].name_change_no_parentage_order | True | |
      | spouse_other_relief | False | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | True | |
    Then I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Jamie Former"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameTwo"
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "Married:"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | not_married | True | |
    When I follow the review link containing "Children under 18:"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | no_minor_children | True | |
    When I tap to continue
    Then the question id should be "download Application_for_name_change"
    When I archive the downloaded PDF "criminal_history_releases.pdf" as "family-releases.pdf"
    And I download "criminal_history_releases.pdf"
    Then the downloaded PDF "criminal_history_releases.pdf" should not contain "Jamie Former"
    And the downloaded PDF "criminal_history_releases.pdf" should not contain "SurnameTwo"
    And the packet does not offer "parental_hearing_notice.pdf"
    When I download "Application_for_name_change.pdf"
    Then the downloaded PDF "Application_for_name_change.pdf" should not contain "Originalspouse"
    And the downloaded PDF "Application_for_name_change.pdf" should not contain "SurnameTwo"
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "Married:"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | not_married | False | |
      | application_includes_spouse | yes_includes_spouse | |
    When I follow the review link containing "Children under 18:"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | no_minor_children | False | |
    When I tap to continue
    Then the question id should be "download Application_for_name_change"
    When I archive the downloaded PDF "criminal_history_releases.pdf" as "solo-releases.pdf"
    And I download "criminal_history_releases.pdf"
    Then the downloaded PDF "criminal_history_releases.pdf" should contain "Jamie Former"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "SurnameTwo"
    When I archive the downloaded PDF "Application_for_name_change.pdf" as "solo-application.pdf"
    And I download "Application_for_name_change.pdf"
    Then the downloaded PDF "Application_for_name_change.pdf" should contain "Newspouse"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "SurnameTwo"
    And I download "parental_hearing_notice.pdf"
    And the downloaded PDF "parental_hearing_notice.pdf" should contain "Other Parent"

  @child_removal
  Scenario: Deleting a child keeps requested names with the remaining children
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
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | request_childrens_name_change | True | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2013 | |
      | children[1].name.first | Second | |
      | children[1].name.last | SurnameTwo | |
      | children[1].birthdate | 01/02/2014 | |
      | children[2].name.first | Third | |
      | children[2].name.last | SurnameThree | |
      | children[2].birthdate | 01/02/2015 | |
      | children1_name_first_change | Avery | |
      | children1_name_last_change | Newname | |
      | children2_name_first_change | Blair | |
      | children2_name_last_change | Newname | |
      | children3_name_first_change | Casey | |
      | children3_name_last_change | Newname | |
      | parents_nonapplicant_name_first | Other | |
      | parents_nonapplicant_name_last | Parent | |
      | parents_nonapplicant_address_address | 456 Sample Avenue | |
      | parents_nonapplicant_city_state_zip | St. Paul, MN 55101 | |
      | children[0].name_change_parent_role | legal_parent | |
      | children[0].name_change_parent_basis | birth_certificate | |
      | children[0].name_change_authority_uncertain | False | |
      | children[0].name_change_resident_six_months | True | |
      | children[0].name_change_same_home | True | |
      | children[0].name_change_relief | name_only | |
      | children[0].name_change_other_parent_status | one_known | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | children[1].name_change_parent_role | legal_parent | |
      | children[1].name_change_parent_basis | birth_certificate | |
      | children[1].name_change_authority_uncertain | False | |
      | children[1].name_change_resident_six_months | True | |
      | children[1].name_change_same_home | True | |
      | children[1].name_change_relief | name_only | |
      | children[1].name_change_other_parent_status | one_known | |
      | children[1].name_change_shared_parent_confirmed | True | |
      | children[1].name_change_no_parent_on_certificate | True | |
      | children[1].name_change_no_marriage_presumption | True | |
      | children[1].name_change_no_recognition | True | |
      | children[1].name_change_no_parentage_order | True | |
      | children[2].name_change_parent_role | legal_parent | |
      | children[2].name_change_parent_basis | birth_certificate | |
      | children[2].name_change_authority_uncertain | False | |
      | children[2].name_change_resident_six_months | True | |
      | children[2].name_change_same_home | True | |
      | children[2].name_change_relief | name_only | |
      | children[2].name_change_other_parent_status | one_known | |
      | children[2].name_change_shared_parent_confirmed | True | |
      | children[2].name_change_no_parent_on_certificate | True | |
      | children[2].name_change_no_marriage_presumption | True | |
      | children[2].name_change_no_recognition | True | |
      | children[2].name_change_no_parentage_order | True | |
      | spouse_other_relief | False | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | True | |
    Then I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Avery"
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "names and birth dates"
    And I remove child number 1 from the family list
    And I tap to continue
    And I tap to continue
    Then the question id should be "download Application_for_name_change"
    When I archive the downloaded PDF "Application_for_name_change.pdf" as "before-removal.pdf"
    And I download "Application_for_name_change.pdf"
    Then the downloaded PDF "Application_for_name_change.pdf" should not contain "Avery"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Blair"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Casey"
    When I download "proposed_name_change_order.pdf"
    Then the downloaded PDF "proposed_name_change_order.pdf" should contain "Second SurnameTwo"
    And the downloaded PDF "proposed_name_change_order.pdf" should not contain "Avery"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Casey"
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "names and birth dates"
    And I follow the review link containing "Add another"
    And I get to "edit children" with this data:
      | var | value | trigger |
      | children[2].name.first | Added | |
      | children[2].name.last | Newchild | |
      | children[2].birthdate | 01/02/2016 | |
    When I tap to continue
    And I tap to continue
    And I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | children[2].name_change_parent_role | legal_parent | |
      | children[2].name_change_parent_basis | birth_certificate | |
      | children[2].name_change_authority_uncertain | False | |
      | children[2].name_change_resident_six_months | True | |
      | children[2].name_change_same_home | True | |
      | children[2].name_change_relief | name_only | |
      | children[2].name_change_other_parent_status | one_known | |
      | children[2].name_change_shared_parent_confirmed | True | |
      | children3_name_first_change | Devin | |
      | children3_name_last_change | Newname | |
      | children[2].release_other_names | | |
      | children[2].release_sex | Female | |
      | children[2].release_race | White | |
    When I archive the downloaded PDF "Application_for_name_change.pdf" as "after-removal.pdf"
    And I download "Application_for_name_change.pdf"
    Then the downloaded PDF "Application_for_name_change.pdf" should contain "Devin"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Blair"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Casey"
    And the downloaded PDF "Application_for_name_change.pdf" should not contain "Avery"

  @felony_recipient_edits
  Scenario: Removing a spouse requires reviewing a felony notice assigned to that spouse
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
      | court_administrator_address | 15 West Kellogg Boulevard | |
      | court_administrator_city_state_zip | St. Paul, MN 55102 | |
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
      | not_married | False | |
      | no_minor_children | False | |
      | parties_have_criminal_history | True | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | request_childrens_name_change | True | |
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
      | application_includes_spouse | yes_includes_spouse | |
      | spouses[0].name.first | Jamie | |
      | spouses[0].name.last | Originalspouse | |
      | spouses[0].birthdate | 02/03/1971 | |
      | request_applicant_spouse_name_change | True | |
      | spouses_name_first_change | Jamie | |
      | spouses_name_last_change | Newspouse | |
      | spouses[0].address.address | 123 Example Street | |
      | spouses[0].address.city | St. Paul | |
      | spouses[0].address.state | MN | |
      | spouses[0].address.zip | 55101 | |
      | spouses[0].phone_number | 6125550101 | |
      | spouses[0].email | jamie@example.com | |
      | criminal_history | Robin and Jamie have convictions | |
      | parties_with_criminal_history | True | |
      | felony_count | 2 | |
      | party1_with_offense | Jamie Originalspouse | |
      | party1_name_of_offense | Example state offense | |
      | party1_date_of_offense | 2010 | |
      | party1_state_of_offense | Minnesota | |
      | party2_with_offense | Robin Original | |
      | party2_name_of_offense | Example federal offense | |
      | party2_date_of_offense | 2011 | |
      | party2_state_of_offense | Minnesota | |
      | felony_notices[0].person_index | 1 | |
      | felony_notices[0].kind | minnesota | |
      | felony_notices[0].authority | Hennepin County prosecutor | |
      | felony_notices[1].person_index | 0 | |
      | felony_notices[1].kind | federal | |
      | felony_notices[1].authority | United States Attorney | |
      | children[0].name_change_parent_role | legal_parent | |
      | children[0].name_change_parent_basis | birth_certificate | |
      | children[0].name_change_authority_uncertain | False | |
      | children[0].name_change_resident_six_months | True | |
      | children[0].name_change_same_home | True | |
      | children[0].name_change_relief | name_only | |
      | children[0].name_change_other_parent_status | one_known | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | children[1].name_change_parent_role | legal_parent | |
      | children[1].name_change_parent_basis | birth_certificate | |
      | children[1].name_change_authority_uncertain | False | |
      | children[1].name_change_resident_six_months | True | |
      | children[1].name_change_same_home | True | |
      | children[1].name_change_relief | name_only | |
      | children[1].name_change_other_parent_status | one_known | |
      | children[1].name_change_shared_parent_confirmed | True | |
      | children[1].name_change_no_parent_on_certificate | True | |
      | children[1].name_change_no_marriage_presumption | True | |
      | children[1].name_change_no_recognition | True | |
      | children[1].name_change_no_parentage_order | True | |
      | children[2].name_change_parent_role | legal_parent | |
      | children[2].name_change_parent_basis | birth_certificate | |
      | children[2].name_change_authority_uncertain | False | |
      | children[2].name_change_resident_six_months | True | |
      | children[2].name_change_same_home | True | |
      | children[2].name_change_relief | name_only | |
      | children[2].name_change_other_parent_status | one_known | |
      | children[2].name_change_shared_parent_confirmed | True | |
      | children[2].name_change_no_parent_on_certificate | True | |
      | children[2].name_change_no_marriage_presumption | True | |
      | children[2].name_change_no_recognition | True | |
      | children[2].name_change_no_parentage_order | True | |
      | spouse_other_relief | False | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | True | |
    Then I download "felony_name_change_notices.pdf"
    And the downloaded PDF "felony_name_change_notices.pdf" should contain "Jamie Originalspouse"
    And the downloaded PDF "felony_name_change_notices.pdf" should contain "United States Attorney"
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "Married:"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | not_married | False | |
      | application_includes_spouse | no_includes_spouse | |
    When I tap to continue
    Then the question id should be "felony notice recipient"
    And I should see the phrase "The person you selected for this notice is no longer applying."
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | felony_notices[0].person_index | 0 | |
      | felony_notices[0].kind | minnesota | |
      | felony_notices[0].authority | Ramsey County prosecutor | |
    When I archive the downloaded PDF "felony_name_change_notices.pdf" as "before-spouse-removal.pdf"
    And I download "felony_name_change_notices.pdf"
    Then the downloaded PDF "felony_name_change_notices.pdf" should not contain "Jamie Originalspouse"
    And the downloaded PDF "felony_name_change_notices.pdf" should contain "Ramsey County prosecutor"
    And the downloaded PDF "felony_name_change_notices.pdf" should contain "United States Attorney"
