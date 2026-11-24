@validation
Feature: Financial and family validation

  @structured_finances
  Scenario: Structured finances calculate totals and recalculate after income edits
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
      | fee_legal_services | False | |
      | fee_public_assistance | none | |
      | fee_household_people.there_are_any | True | |
      | fee_household_people[0].full_name | Jamie Partner | |
      | fee_household_people[0].age | 28 | |
      | fee_household_people[0].relationship | partner | |
      | fee_household_people[0].monthly_take_home | 500 | |
      | fee_household_people[0].income_source | Part-time job | |
      | fee_household_people.there_is_another | False | |
      | fee_income_sources | Job | |
      | fee_monthly_income | 3000 | |
      | fee_income_is_average | False | |
      | fee_yearly_income | 42000 | |
      | fee_manual_below_guideline | False | |
      | fee_debt | 1000 | |
      | fee_cash | 5 | |
      | fee_accounts | 10 | |
      | fee_other_reasons | Medical emergency | |
      | fee_property.there_are_any | True | |
      | fee_property[0].kind | vehicle | |
      | fee_property[0].description | 2015 Example Car | |
      | fee_property[0].estimated_value | 5000 | |
      | fee_property[0].amount_owed | 2000 | |
      | fee_property[1].kind | personal | |
      | fee_property[1].description | Savings bonds | |
      | fee_property[1].estimated_value | 200 | |
      | fee_property[1].amount_owed | 0 | |
      | fee_expense_housing | 1000 | |
      | fee_expense_utilities | 150 | |
      | fee_expense_food | 300 | |
      | fee_expense_car_payments | 100 | |
      | fee_expense_car_insurance | 75 | |
      | fee_expense_child_support | 0 | |
      | fee_expense_spousal_support | 0 | |
      | fee_expense_childcare | 0 | |
      | fee_expense_medical | 50 | |
      | fee_expense_phone | 40 | |
      | fee_expense_other | 25 | |
      | fee_expense_other_description | Internet | |
      | fee_property.target_number | 2 | |
    Then I download "fee_waiver_affidavit.pdf"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Jamie Partner, age 28, partner"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Total monthly expenses: $1740.00"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Total equity: $3200.00"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "42000.00"
    When I follow the review link containing "Edit packet information"
    And I follow the review link containing "Housing and living expenses"
    And I get to "review packet choices" with this data:
      | var | value | trigger |
      | fee_expense_housing | 1100 | |
    When I tap to continue
    And I discard the previous download "fee_waiver_affidavit.pdf"
    And I download "fee_waiver_affidavit.pdf"
    Then the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Total monthly expenses: $1840.00"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should not contain "Total monthly expenses: $1740.00"
    When I follow the review link containing "Edit packet information"
    And I follow the review link containing "Property and equity"
    And I edit the table row containing "2015 Example Car"
    And I get to "review packet choices" with this data:
      | var | value | trigger |
      | fee_property[0].amount_owed | 4000 | |
    When I tap to continue
    And I discard the previous download "fee_waiver_affidavit.pdf"
    And I download "fee_waiver_affidavit.pdf"
    Then the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Total equity: $1200.00"
    When I follow the review link containing "Edit packet information"
    And I follow the review link containing "Yearly household income"
    And I get to "review packet choices" with this data:
      | var | value | trigger |
      | fee_yearly_income | 20000 | |
      | fee_manual_below_guideline | True | |
    When I tap to continue
    Then the question id should be "review yearly income difference"
    And I should see the phrase "Your yearly amount is lower"
    When I tap to continue
    Then the question id should be "download Application_for_name_change"
    When I discard the previous download "fee_waiver_affidavit.pdf"
    And I download "fee_waiver_affidavit.pdf"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "20000.00"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should not contain "Total monthly expenses"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should not contain "2015 Example Car"
    When I follow the review link containing "Edit packet information"
    And I follow the review link containing "Household members"
    Then the question id should be "review fee household"
    When I edit the table row containing "Jamie Partner"
    And I set the variable "fee_household_people[0].relationship" to "spouse"
    Then I cannot continue
    And I should see the phrase "You told us you are not married"
    When I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | fee_household_people[0].full_name | Morgan Partner | |
      | fee_household_people[0].relationship | partner | |
      | fee_household_people[0].monthly_take_home | 750 | |
      | fee_household_people[0].income_source | Updated job | |
    When I discard the previous download "fee_waiver_affidavit.pdf"
    And I download "fee_waiver_affidavit.pdf"
    Then the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Morgan Partner, age 28, partner"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "$750.00 monthly take-home"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should not contain "Jamie Partner"
    When I follow the review link containing "Edit packet information"
    And I follow the review link containing "Household members"
    And I delete the table row containing "Morgan Partner"
    And I get to "download Application_for_name_change" with this data:
      | var | value | trigger |
      | fee_household_people.there_are_any | False | |
      | fee_manual_below_guideline | False | |
    When I discard the previous download "fee_waiver_affidavit.pdf"
    And I download "fee_waiver_affidavit.pdf"
    Then the downloaded PDF "fee_waiver_affidavit.pdf" should contain "My household size is 1."
    And the downloaded PDF "fee_waiver_affidavit.pdf" should not contain "Morgan Partner"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Total monthly expenses: $1840.00"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "Total equity: $1200.00"


  @child_partial_name
  Scenario: A partial requested child name must be completed
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "child 1 requested name" with this data:
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
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
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
    When I set the variable "children1_name_first_change" to "Avery"
    Then I cannot continue
    And I should see the phrase "Enter both a first and last name"
    When I set the variable "children1_name_last_change" to "Newname"
    And I tap to continue
    Then the question id should be "child 2 requested name"

  @adult_child_guard
  Scenario: An adult in the minor-child list gets an editable referral
    Given I start the interview at "Application_for_name_change.yml"
    And the maximum seconds for each step is 90
    When I get to "child age help" with this data:
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
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | request_childrens_name_change | True | |
      | parents_nonapplicant_unknown | True | |
      | children[0].name.first | First | |
      | children[0].name.last | Child | |
      | children[0].birthdate | 01/02/2000 | |
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
    Then I should see the phrase "This list is for children under 18"
    And I should see the phrase "Edit birth date"
    When I follow the review link containing "Edit birth date"
    And I get to "download Application_for_name_change" with this data:
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
      | no_minor_children | False | |
      | parties_have_criminal_history | False | |
      | applicant_spouse_or_children_have_claim_interest_or_lien_in_Minnesota | parties_do_not_have_claim_interest_or_lien | |
      | users1_involved_in_victim_or_witness_protection | False | |
      | users1_inmate_in_correctional_facility_and_submitting_inmate_aff | False | |
      | users1_divorced_seeking_change_to_legal_name_on_birth_certificate | False | |
      | children.target_number | 3 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
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
    Then I download "criminal_history_releases.pdf"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "First Child"

  @county_edit
  Scenario: Changing filing county recalculates district and order count
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
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "IT IS ORDERED that:" exactly 2 times
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "County where you will file"
    And I get to "Application for name change review screen" with this data:
      | var | value | trigger |
      | district_court_county | Ramsey | |
    When I tap to continue
    Then the question id should be "download Application_for_name_change"
    When I discard the previous download "proposed_name_change_order.pdf"
    And I download "proposed_name_change_order.pdf"
    Then the downloaded PDF "proposed_name_change_order.pdf" should contain "IT IS ORDERED that:" exactly 1 times
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Second"
    And the downloaded PDF "proposed_name_change_order.pdf" should not contain "Fourth"
