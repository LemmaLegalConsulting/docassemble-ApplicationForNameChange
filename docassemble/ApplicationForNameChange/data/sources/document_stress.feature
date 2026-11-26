Feature: Synthetic document stress and layout review

  @document_stress @stress_latin_declarations
  Scenario: Long Latin names and multi-page declarations survive assembly
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
      | court_administrator_address | 15 West Kellogg Boulevard | |
      | court_administrator_city_state_zip | St. Paul, MN 55102 | |
      | felony_notices[0].person_index | 0 | |
      | felony_notices[0].kind | minnesota | |
      | felony_notices[0].authority | Ramsey County, Minnesota | |
      | users[0].name.first | Alexandria-Cassandre Éléonore | |
      | users[0].name.last | García-Montgomery-Washington-Świątek | |
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
      | users1_name_first_change | Alexandria-Cassandre Éléonore | |
      | users1_name_last_change | Dvořák-Nguyễn-Łukaszewicz | |
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
      | fee_legal_services | False | |
      | fee_public_assistance | none | |
      | fee_household_people.there_are_any | False | |
      | fee_income_sources | Job | |
      | fee_monthly_income | 3000 | |
      | fee_income_is_average | False | |
      | fee_yearly_income | 36000 | |
      | fee_manual_below_guideline | False | |
      | fee_expense_housing | 2000 | |
      | fee_expense_utilities | 100 | |
      | fee_expense_food | 400 | |
      | fee_expense_car_payments | 0 | |
      | fee_expense_car_insurance | 0 | |
      | fee_expense_child_support | 0 | |
      | fee_expense_spousal_support | 0 | |
      | fee_expense_childcare | 0 | |
      | fee_expense_medical | 100 | |
      | fee_expense_phone | 50 | |
      | fee_expense_other | 0 | |
      | fee_debt | 1000 | |
      | fee_cash | 5 | |
      | fee_accounts | 10 | |
      | fee_property.there_are_any | False | |
      | fee_other_reasons | START-FEE-REASONS. Item 01: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 02: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 03: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 04: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 05: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 06: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 07: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 08: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 09: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 10: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 11: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 12: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 13: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 14: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 15: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 16: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 17: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 18: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 19: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 20: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 21: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 22: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 23: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 24: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 25: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 26: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 27: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 28: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 29: Fictional medical and transport expenses vary each month; this example uses invented financial details. Item 30: Fictional medical and transport expenses vary each month; this example uses invented financial details. ENDFEEREASONS | |
      | users1_other_statements | START-STATEMENT. Section 01: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 02: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 03: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 04: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 05: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 06: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 07: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 08: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 09: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 10: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 11: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 12: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 13: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 14: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 15: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 16: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 17: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 18: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 19: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 20: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 21: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 22: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 23: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 24: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 25: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 26: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 27: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 28: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 29: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 30: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 31: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 32: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 33: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 34: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 35: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 36: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 37: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 38: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 39: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 40: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 41: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 42: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 43: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 44: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 45: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 46: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 47: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 48: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 49: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 50: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 51: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 52: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 53: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 54: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 55: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 56: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 57: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 58: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 59: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. Section 60: This synthetic declaration explains a fictional name-change request; no real person or legal event is described. END-STATEMENT. | |
      | name_of_person_and_description_of_person_with_claim_interest_or_lien | START-PROPERTY. Parcel 01: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 02: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 03: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 04: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 05: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 06: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 07: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 08: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 09: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 10: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 11: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 12: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 13: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 14: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 15: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 16: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 17: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 18: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 19: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 20: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 21: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 22: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 23: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 24: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 25: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 26: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 27: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 28: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 29: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. Parcel 30: Lot 1, Block 2, Example Addition, Ramsey County, Minnesota; synthetic description only. END-PROPERTY. | |
    And I download "Application_for_name_change.pdf"
    And I download "proposed_name_change_order.pdf"
    And I download "criminal_history_releases.pdf"
    And I download "fee_waiver_affidavit.pdf"
    And I download "Application_for_name_change_next_steps.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "START-STATEMENT."
    And the downloaded PDF "Application_for_name_change.pdf" should contain "END-STATEMENT."
    And the downloaded PDF "Application_for_name_change.pdf" should contain "START-PROPERTY."
    And the downloaded PDF "Application_for_name_change.pdf" should contain "END-PROPERTY."
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Dvořák-Nguyễn-Łukaszewicz"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "END-STATEMENT."
    And the downloaded PDF "criminal_history_releases.pdf" should contain "García-Montgomery-Washington-Świątek"
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "START-FEE-REASONS."
    And the downloaded PDF "fee_waiver_affidavit.pdf" should contain "ENDFEEREASONS"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "García-Montgomery-Washington-Świątek"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Dvořák-Nguyễn-Łukaszewicz"

  @document_stress @stress_cjk
  Scenario: CJK names survive PDF form fields and companion documents
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
      | court_administrator_address | 15 West Kellogg Boulevard | |
      | court_administrator_city_state_zip | St. Paul, MN 55102 | |
      | felony_notices[0].person_index | 0 | |
      | felony_notices[0].kind | minnesota | |
      | felony_notices[0].authority | Ramsey County, Minnesota | |
      | users[0].name.first | 美咲 | |
      | users[0].name.last | 山田 | |
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
      | users1_name_first_change | 美咲 | |
      | users1_name_last_change | 高橋 | |
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
    And I download "Application_for_name_change.pdf"
    And I download "proposed_name_change_order.pdf"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "美咲"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "山田"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "高橋"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "美咲"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "高橋"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "山田"

  @document_stress @stress_five_children
  Scenario: Five long family names paginate across Hennepin orders and releases
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
      | court_administrator_address | 15 West Kellogg Boulevard | |
      | court_administrator_city_state_zip | St. Paul, MN 55102 | |
      | felony_notices[0].person_index | 0 | |
      | felony_notices[0].kind | minnesota | |
      | felony_notices[0].authority | Ramsey County, Minnesota | |
      | users[0].name.first | Alexandria-Cassandre Éléonore | |
      | users[0].name.last | García-Montgomery-Washington-Świątek | |
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
      | users1_name_first_change | Alexandria-Cassandre Éléonore | |
      | users1_name_last_change | Dvořák-Nguyễn-Łukaszewicz | |
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
      | children.target_number | 5 | |
      | minor_children_listed_not_included_in_application | minor_children_included_yes | |
      | request_childrens_name_change | True | |
      | children[0].name.first | Élodie-Alexandria | |
      | children[0].name.last | García-Montgomery-Washington-Świątek | |
      | children[0].birthdate | 01/02/2010 | |
      | children[1].name.first | Søren-Maximiliano | |
      | children[1].name.last | García-Montgomery-Washington-Świątek | |
      | children[1].birthdate | 01/02/2011 | |
      | children[2].name.first | Zoë-Cassandra | |
      | children[2].name.last | García-Montgomery-Washington-Świątek | |
      | children[2].birthdate | 01/02/2012 | |
      | children1_name_first_change | Élodie-Alexandria | |
      | children1_name_last_change | Dvořák-Nguyễn-Łukaszewicz | |
      | children2_name_first_change | Søren-Maximiliano | |
      | children2_name_last_change | Dvořák-Nguyễn-Łukaszewicz | |
      | children3_name_first_change | Zoë-Cassandra | |
      | children3_name_last_change | Dvořák-Nguyễn-Łukaszewicz | |
      | children[3].birthdate | 01/02/2013 | |
      | children[3].release_other_names |  | |
      | children[3].release_sex | Female | |
      | children[3].release_race | White | |
      | children[4].birthdate | 01/02/2014 | |
      | children[4].release_other_names |  | |
      | children[4].release_sex | Female | |
      | children[4].release_race | White | |
      | children[3].name.first | Łukasz-Sebastian | |
      | children[3].name.last | García-Montgomery-Washington-Świątek | |
      | children4_name_first_change | Łukasz-Sebastian | |
      | children4_name_last_change | Dvořák-Nguyễn-Łukaszewicz | |
      | children[4].name.first | Anaïs-Valentina | |
      | children[4].name.last | García-Montgomery-Washington-Świątek | |
      | children5_name_first_change | Anaïs-Valentina | |
      | children5_name_last_change | Dvořák-Nguyễn-Łukaszewicz | |
      | children[0].name_change_parent_role | legal_parent | |
      | children[0].name_change_parent_basis | birth_certificate | |
      | children[0].name_change_authority_uncertain | False | |
      | children[0].name_change_resident_six_months | True | |
      | children[0].name_change_same_home | True | |
      | children[0].name_change_relief | name_only | |
      | children[0].name_change_other_parent_status | none_unknown | |
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
      | children[1].name_change_other_parent_status | none_unknown | |
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
      | children[2].name_change_other_parent_status | none_unknown | |
      | children[2].name_change_no_parent_on_certificate | True | |
      | children[2].name_change_no_marriage_presumption | True | |
      | children[2].name_change_no_recognition | True | |
      | children[2].name_change_no_parentage_order | True | |
      | children[3].name_change_parent_role | legal_parent | |
      | children[3].name_change_parent_basis | birth_certificate | |
      | children[3].name_change_authority_uncertain | False | |
      | children[3].name_change_resident_six_months | True | |
      | children[3].name_change_same_home | True | |
      | children[3].name_change_relief | name_only | |
      | children[3].name_change_other_parent_status | none_unknown | |
      | children[3].name_change_no_parent_on_certificate | True | |
      | children[3].name_change_no_marriage_presumption | True | |
      | children[3].name_change_no_recognition | True | |
      | children[3].name_change_no_parentage_order | True | |
      | children[4].name_change_parent_role | legal_parent | |
      | children[4].name_change_parent_basis | birth_certificate | |
      | children[4].name_change_authority_uncertain | False | |
      | children[4].name_change_resident_six_months | True | |
      | children[4].name_change_same_home | True | |
      | children[4].name_change_relief | name_only | |
      | children[4].name_change_other_parent_status | none_unknown | |
      | children[4].name_change_no_parent_on_certificate | True | |
      | children[4].name_change_no_marriage_presumption | True | |
      | children[4].name_change_no_recognition | True | |
      | children[4].name_change_no_parentage_order | True | |
    And I download "Application_for_name_change.pdf"
    And I download "proposed_name_change_order.pdf"
    And I download "criminal_history_releases.pdf"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Anaïs-Valentina"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Anaïs-Valentina"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "Dvořák-Nguyễn-Łukaszewicz"
    And the downloaded PDF "criminal_history_releases.pdf" should contain "Anaïs-Valentina"

    And the downloaded PDF "proposed_name_change_order.pdf" should contain "1. The application is made in good faith" exactly 6 times
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Additional minor signatures for NAM102"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Minor: Élodie-Alexandria García-Montgomery-Washington-Świątek"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Minor: Søren-Maximiliano García-Montgomery-Washington-Świątek"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Minor: Zoë-Cassandra García-Montgomery-Washington-Świątek"
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "6. This applicant requests:" exactly 6 times
    And the downloaded PDF "proposed_name_change_order.pdf" should contain "9. Other:" exactly 6 times
    And the downloaded PDF "proposed_name_change_order.pdf" should have no empty content pages
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "names and birth dates"
    And I remove child number 1 from the family list
    And I tap to continue
    And I tap to continue
    Then the question id should be "download Application_for_name_change"
    When I archive the downloaded PDF "Application_for_name_change.pdf" as "five-child-application.pdf"
    And I download "Application_for_name_change.pdf"
    Then the downloaded PDF "Application_for_name_change.pdf" should not contain "Minor: Élodie-Alexandria"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Minor: Søren-Maximiliano"
    And the downloaded PDF "Application_for_name_change.pdf" should contain "Minor: Zoë-Cassandra"
    When I archive the downloaded PDF "proposed_name_change_order.pdf" as "six-orders.pdf"
    And I download "proposed_name_change_order.pdf"
    Then the downloaded PDF "proposed_name_change_order.pdf" should contain "1. The application is made in good faith" exactly 5 times
    And the downloaded PDF "proposed_name_change_order.pdf" should have no empty content pages
