@parent_child_rules
Feature: Supported parent and child packet routes

  @guardian_referral
  Scenario: Guardian receives a referral
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children[0].name_change_parent_role | guardian | |
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
    Then I should see the phrase "does not mean that the law prevents you from applying"

  @parentage_referral
  Scenario: Recognition of Parentage needs review
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children[0].name_change_parent_basis | other_basis | |
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
    Then I should see the phrase "Recognition of Parentage"

  @child_residence_referral
  Scenario: Different child residence needs review
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children[0].name_change_same_home | False | |
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
    Then I should see the phrase "shared-address"

  @child_relief_referral
  Scenario: Child birth-record relief needs review
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children[0].name_change_relief | birth_record | |
      | children[0].name_change_other_parent_status | one_known | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | spouse_other_relief | False | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | True | |
    Then I should see the phrase "birth-record changes"

  @known_identity_referral
  Scenario: Known identity cannot become an unknown-parent checkbox
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children[0].name_change_other_parent_status | none_known | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | spouse_other_relief | False | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | True | |
    Then I should see the phrase "must not be described as unknown"

  @different_parent_referral
  Scenario: Different other parent needs review
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children[0].name_change_shared_parent_confirmed | False | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | spouse_other_relief | False | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | True | |
    Then I should see the phrase "different parent groups"

  @unconfirmed_notice_referral
  Scenario: Unconfirmed county service method needs review
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | parent_service_method | unsure | |
      | parent_notice_exception_court_confirmed | True | |
    Then I should see the phrase "Confirm the method"

  @hennepin_address_referral
  Scenario: Hennepin unknown address needs a search affidavit
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | district_court_county | Hennepin | |
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
    Then I should see the phrase "notarized search affidavit"

  @court_order_parent
  Scenario: Court-established parent can prepare the packet
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
      | children[0].name_change_parent_basis | court_order | |
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
    Then I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "First"

  @hennepin_certified_mail
  Scenario: Hennepin known address uses certified mail
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
      | district_court_county | Hennepin | |
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
    Then I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "First"
    And I download "Application_for_name_change_next_steps.pdf"
    And the downloaded PDF "Application_for_name_change_next_steps.pdf" should have no empty content pages
    And the downloaded PDF "Application_for_name_change_next_steps.pdf" should contain "certified mail"
    And the downloaded PDF "Application_for_name_change_next_steps.pdf" should contain "14 days"
    And the packet does not offer "parental_personal_service.pdf"
    And the packet does not offer "NAM204.pdf"
    And the packet does not offer "NAM101-supp.pdf"


  @guardian_recovery
  Scenario: Guardian continues adults only and keeps the child listed
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children[0].name.last | RetainedMinor | |
      | children[0].birthdate | 01/02/2013 | |
      | children1_name_first_change | First | |
      | children1_name_last_change | Newname | |
      | parents_nonapplicant_name_first | Other | |
      | parents_nonapplicant_name_last | Parent | |
      | parents_nonapplicant_address_address | 456 Sample Avenue | |
      | parents_nonapplicant_city_state_zip | St. Paul, MN 55101 | |
      | children[0].name_change_parent_role | guardian | |
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
    Then I should see the phrase "does not mean that the law prevents you from applying"

    When I follow the review link containing "Continue with adults only"
    And I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | request_fee_waiver | False | |
      | users[0].release_other_names | Robin Former | |
      | users[0].release_sex | Female | |
      | users[0].release_race | White | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
    Then I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "RetainedMinor"
    And the packet does not offer "parental_hearing_notice.pdf"
    When I download "proposed_name_change_order.pdf"
    Then the downloaded PDF "proposed_name_change_order.pdf" should not contain "RetainedMinor" between "This application includes the following minor children listed above:" and "7. The applicant"
    When I download "criminal_history_releases.pdf"
    Then the downloaded PDF "criminal_history_releases.pdf" should not contain "RetainedMinor"


  @mixed_birth_record_referral
  Scenario: Adult birth-record-only relief plus child changes needs court guidance
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
      | var | value | trigger |
      | users1_name_first_change_birth_record | Robin | |
      | users1_name_last_change_birth_record | Original | |
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
      | request_for_applicant_name_change | False | |
      | users1_name_first_change | Robin | |
      | users1_name_last_change | Newname | |
      | request_for_applicant_name_change_on_birth_record | True | |
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
    Then I should see the phrase "birth-record relief for an adult"


  @spouse_relief_referral
  Scenario: Spouse additional relief needs court guidance
    # Only applicable people and requests should be gathered; entered data and overflow must survive document assembly.
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "spouse additional relief referral" with this data:
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
      | spouse_other_relief | True | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | True | |
    Then I should see the phrase "separate paperwork"


  @parent_child_followup @county_exception_referral
  Scenario: A county notice exception needs court confirmation
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children[0].name_change_other_parent_status | none_unknown | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | children[0].name_change_no_parent_on_certificate | True | |
      | children[0].name_change_no_marriage_presumption | True | |
      | children[0].name_change_no_recognition | True | |
      | children[0].name_change_no_parentage_order | True | |
      | spouse_other_relief | False | |
      | parent_service_method | personal_service | |
      | parent_notice_exception_court_confirmed | False | |
    Then I should see the phrase "confirm whether notice may be omitted"
    And I should see the phrase "Edit the county confirmation"
    When I follow the review link containing "Edit the other-parent situation"
    And I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | children[0].name_change_other_parent_status | one_known | |
      | parents_nonapplicant_name_first | Other | |
      | parents_nonapplicant_name_last | Parent | |
      | parent_address_known | True | |
      | parents_nonapplicant_address_address | 456 Sample Avenue | |
      | parents_nonapplicant_city_state_zip | St. Paul, MN 55101 | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | parent_service_method | personal_service | |
      | users[0].release_other_names | Robin Former | |
      | users[0].release_sex | Female | |
      | users[0].release_race | White | |
      | children[0].release_other_names | | |
      | children[0].release_sex | Female | |
      | children[0].release_race | White | |
      | request_fee_waiver | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
    Then the packet offers "parental_personal_service.pdf"
    When I download "parental_personal_service.pdf"
    Then the downloaded PDF "parental_personal_service.pdf" should contain "Other Parent"

  @parent_child_followup @mixed_parent_recovery
  Scenario: Mixed parent groups refer and one child can remain listed without a request
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "parent child referral" with this data:
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
      | children.target_number | 2 | |
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
      | children[1].name.first | Second | |
      | children[1].name.last | ListedOnlyChild | |
      | children[1].birthdate | 01/02/2014 | |
      | children[1].name_change_parent_role | legal_parent | |
      | children[1].name_change_parent_basis | court_order | |
      | children[1].name_change_authority_uncertain | False | |
      | children[1].name_change_resident_six_months | True | |
      | children[1].name_change_same_home | True | |
      | children[1].name_change_relief | name_only | |
      | children[1].name_change_other_parent_status | none_unknown | |
      | children2_name_first_change | Second | |
      | children2_name_last_change | Newname | |
    Then I should see the phrase "different parent groups"
    And I should see the phrase "Edit other-parent situation for Second ListedOnlyChild"
    When I follow the review link containing "Leave this child listed"
    And I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | request_fee_waiver | False | |
      | parents_nonapplicant_name_first | Other | |
      | parents_nonapplicant_name_last | Parent | |
      | parent_address_known | True | |
      | parents_nonapplicant_address_address | 456 Sample Avenue | |
      | parents_nonapplicant_city_state_zip | St. Paul, MN 55101 | |
      | children[0].name_change_shared_parent_confirmed | True | |
      | parent_service_method | personal_service | |
      | users[0].release_other_names | Robin Former | |
      | users[0].release_sex | Female | |
      | users[0].release_race | White | |
      | children[0].release_other_names | | |
      | children[0].release_sex | Female | |
      | children[0].release_race | White | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
    Then I download "Application_for_name_change.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "ListedOnlyChild"
    When I download "proposed_name_change_order.pdf"
    Then the downloaded PDF "proposed_name_change_order.pdf" should contain "First Child" between "This application includes the following minor children listed above:" and "6. This applicant requests:"
    And the downloaded PDF "proposed_name_change_order.pdf" should not contain "ListedOnlyChild" between "This application includes the following minor children listed above:" and "7. The applicant"
    When I download "criminal_history_releases.pdf"
    Then the downloaded PDF "criminal_history_releases.pdf" should contain "First Child"
    And the downloaded PDF "criminal_history_releases.pdf" should not contain "ListedOnlyChild"
