Feature: Get through SP6A interview

  Runs the `SP6A.yml` interview to completion, with several different variations.

  @sp6a_interview @si1 @fast
  Scenario: sp6a starts
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 30
    And I set the variable "acknowledged_information_use['I accept the terms of use.']" to "True"
    And I tap to continue

  @sp6a_interview @si2
  Scenario: sp6a no e-filing, to end
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 40
    And I get to the question id "download form" with this data:
      | var | value | trigger |
      | acknowledged_information_use['I accept the terms of use.'] | True | |
      | is_initial_filing | True | |
      | user_wants_affidavit | False | |
      | users[0].name.first | Bob | |
      | users[0].name.last | Ma | |
      | users[0].email | example@example.com | |
      | users[0].address.address | 123 Fake St | |
      | users[0].address.city | Boston | |
      | users[0].address.state | MA | |
      | users[0].address.zip | 02122 | |
      | users[0].phone_number | 123-456-7890 | |
      | users.there_is_another | False | |
      | other_parties.there_are_any | True | |
      | other_parties.target_number | 1 | |
      | other_parties[0].person_type | individual | |
      | other_parties[0].name.first | Brandon | |
      | other_parties[0].name.last | Man | |
      | user_needs_interpreter | False ||
      | forty_eight_hour_notice | False | |
      | housing_court | all_courts[45] | |
      | lower_court_case.docket_number | 1234567 | |
      | lower_court_case.judgment_date | 06/20/2022 | |
      | lower_court_case.judge | Judge Ben | |
      | lower_court_case.judgment_appealing | A Rule 60(b) motion to reconsider | |
      | date_housing_court_denied_motion_to_stay | 06/20/2022 | |
      | housing_court_denying_order_text | Some reason, I'm sure it's very important | |
      | date_notice_of_appeal_filed | 06/20/2022 | |
      | x.has_exhibits | False | exhibit_doc.exhibits.has_exhibits |
      | no_record_statement['no_record'] | True | |
      | procedural_history | A lot of stuff happened | |
      | statement_of_facts | These things are facts | |
      | defendant_harm | These dependents will suffer harm. | |
      | plaintiff_harm | Plaintiff will suffer no harm. | |
      | public_interest_harm_yesno | False | |
      | legal_issues['Whether the judge committed an error of law by failing to follow the Uniform Summary Process Rules.'] | True | |
      | relief_sought | I am asking for relief. | |
      | likelihood_of_success | Success is pretty likely. | |
      | argument_summary | Here is the summary of my argument. | |
      | method_of_service | email | |
      | parties_to_be_served | All of them | |
      | service_date | today + 10 | |
      | user_ask_role | plaintiff | |
      | public_assistance_kinds['VA Benefits'] | True | |
      | fees['Filing fee'].waive | True | |
      | fees['Filing fee'].amount | 315 | |
      | signature_choice | this_device | |
      | signature_date | today | |
      | users[0].signature | | user[0].signature |

  @sp6a_interview @si3 @efile @slow
  Scenario: sp6a w/e-filing, to end
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 40
    And I get to the question id "eFile Login" with this data:
      | var | value | trigger |
      | acknowledged_information_use['I accept the terms of use.'] | True | |
      | is_initial_filing | True | |
      | user_wants_affidavit | True | |
    And I set the variable "my_username" to secret "TYLER_EMAIL"
    And I set the variable "my_password" to secret "TYLER_PASSWORD"
    Then I tap to continue
    And I get to the question id "download form" with this data:
      | var | value | trigger |
      | forty_eight_hour_notice | False | |
      | is_initial_filing | True | |
      | users[0].name.first | Bob | |
      | users[0].name.last | Ma | |
      | users[0].email | example@example.com | |
      | users[0].address.address | 123 Fake St | |
      | users[0].address.city | Boston | |
      | users[0].address.state | MA | |
      | users[0].address.zip | 02122 | |
      | users[0].phone_number | 123-456-7890 | |
      | housing_case_search.do_what_choice | docket_lookup | |
      | x.docket_number_from_user | 99H85SC000016 | housing_case_search.docket_number_from_user |
      | x.self_in_case | is_filing | housing_case_search.self_in_case |
      | x.self_partip_choice | housing_case_search.found_case.participants[0] | housing_case_search.self_in_case |
      | other_parties.there_is_another | False | |
      | other_parties.there_are_any | False | |
      | users.there_is_another | False | |
      | user_needs_interpreter | False ||
      | plaintiff_name | Brandon Man | |
      | defendant_name | Bob Ma | |
      | housing_court | all_courts[23] | |
      | lower_court_case.docket_number | 1234567 | |
      | lower_court_case.judgment_date | 06/20/2022 | |
      | lower_court_case.judge | Judge Ben | |
      | lower_court_case.judgment_appealing | A Rule 60(b) motion to reconsider | |
      | date_housing_court_denied_motion_to_stay | 06/20/2022 | |
      | housing_court_denying_order_text | Some reason, I'm sure it's very important | |
      | date_notice_of_appeal_filed | 06/20/2022 | |
      | x.has_exhibits | True | exhibit_doc.exhibits.has_exhibits |
      | x[0].title | First Doc | exhibit_doc.exhibits.has_exhibits |
      | x[0].pages | small_pdf.pdf | exhibit_doc.exhibits.has_exhibits |
      | x.document_type | 6586 | motion_to_stay_bundle.document_type |
      | x.has_courtesy_copies | False | motion_to_stay_bundle.has_courtesy_copies |
      | x.has_courtesy_copies | False | affidavit_of_indigency_bundle.has_courtesy_copies |
      | x.document_type | 6586 | affidavitofindigency_attachment.document_type |
      | motion_to_stay_bundle.has_courtesy_copies | False | |
      | procedural_history | A lot of stuff happened | |
      | statement_of_facts | These things are facts | |
      | defendant_harm | These dependents will suffer harm. | |
      | plaintiff_harm | Plaintiff will suffer no harm. | |
      | public_interest_harm_yesno | False | |
      | legal_issues['Whether the judge committed an error of law by failing to follow the Uniform Summary Process Rules.'] | True | |
      | relief_sought | I am asking for relief. | |
      | likelihood_of_success | Success is pretty likely. | |
      | argument_summary | Here is the summary of my argument. | |
      | method_of_service | email | |
      | parties_to_be_served | All of them | |
      | service_date | today + 10 | |
      | user_ask_role | defendant | |
      | public_assistance_kinds['VA Benefits'] | True | |
      | acknowledge_disclaimers['user_agrees_to_disclaimers'] | True | |
      | fees['Filing fee'].waive | True | |
      | fees['Filing fee'].amount | 315 | |
      | signature_choice | this_device | |
      | signature_date | today | |
      | users[0].signature | | user[0].signature |
    Then I tap the "#efile-button" element
    # And I tap to continue

  @sp6a_interview @si4 @efile @slow
  Scenario: sp6a w/e-filing and Aff Supp
  Complete the full form using e-filing, docket number lookup, using Affidavit of Indigency Supplement
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 40
    And I get to the question id "eFile Login" with this data:
      | var | value | trigger |
      | acknowledged_information_use['I accept the terms of use.'] | True | |
      | is_initial_filing | True | |
      | user_wants_affidavit | True | |
    And I set the variable "my_username" to secret "TYLER_EMAIL"
    And I set the variable "my_password" to secret "TYLER_PASSWORD"
    Then I tap to continue
    And I get to the question id "download form" with this data:
      | var | value | trigger |
      | forty_eight_hour_notice | False | |
      | is_initial_filing | True | |
      | users[0].name.first | Bob | |
      | users[0].name.last | Ma | |
      | users[0].email | example@example.com | |
      | users[0].address.address | 123 Fake St | |
      | users[0].address.city | Boston | |
      | users[0].address.state | MA | |
      | users[0].address.zip | 02122 | |
      | users[0].phone_number | 123-456-7890 | |
      | housing_case_search.do_what_choice | docket_lookup | |
      | x.docket_number_from_user | 99H85SC000016 | housing_case_search.docket_number_from_user |
      | x.self_in_case | is_filing | housing_case_search.self_in_case |
      | x.self_partip_choice | housing_case_search.found_case.participants[0] | housing_case_search.self_in_case |
      | other_parties.there_is_another | False | |
      | other_parties.there_are_any | False | |
      | users.there_is_another | False | |
      | user_needs_interpreter | False ||
      | plaintiff_name | Brandon Man | |
      | defendant_name | Bob Ma | |
      | housing_court | all_courts[23] | |
      | lower_court_case.docket_number | 1234567 | |
      | lower_court_case.judgment_date | 06/20/2022 | |
      | lower_court_case.judge | Judge Ben | |
      | lower_court_case.judgment_appealing | A Rule 60(b) motion to reconsider | |
      | date_housing_court_denied_motion_to_stay | 06/20/2022 | |
      | housing_court_denying_order_text | Some reason, I'm sure it's very important | |
      | date_notice_of_appeal_filed | 06/20/2022 | |
      | x.has_exhibits | True | exhibit_doc.exhibits.has_exhibits |
      | x[0].title | First Doc | exhibit_doc.exhibits.has_exhibits |
      | x[0].pages | small_pdf.pdf | exhibit_doc.exhibits.has_exhibits |
      | x.document_type | 6586 | motion_to_stay_bundle.document_type |
      | x.has_courtesy_copies | False | motion_to_stay_bundle.has_courtesy_copies |
      | x.has_courtesy_copies | False | affidavit_of_indigency_bundle.has_courtesy_copies |
      | x.document_type | 6586 | affidavitofindigency_attachment.document_type |
      | motion_to_stay_bundle.has_courtesy_copies | False | |
      | procedural_history | A lot of stuff happened | |
      | statement_of_facts | These things are facts | |
      | defendant_harm | These dependents will suffer harm. | |
      | plaintiff_harm | Plaintiff will suffer no harm. | |
      | public_interest_harm_yesno | False | |
      | legal_issues['Whether the judge committed an error of law by failing to follow the Uniform Summary Process Rules.'] | True | |
      | relief_sought | I am asking for relief. | |
      | likelihood_of_success | Success is pretty likely. | |
      | argument_summary | Here is the summary of my argument. | |
      | method_of_service | email | |
      | public_assistance_kinds['None'] | True | |
      | parties_to_be_served | All of them | |
      | service_date | today + 10 | |
      | user_ask_role | defendant | |
      | has_household_members | False | |
      | hh_income.value | 1000000 | |
      | hh_income.period | 12 | |
      | can_afford | False | |
      | users[0].birthdate | 12/12/1998 | |
      | user_grade_school_completed | 11th grade | |
      | users[0].jobs.target_number | 0 | |
      | users[0].nonemployment.selected_types['royalties'] | True | |
      | users[0].nonemployment[i].times_per_year | 12 | users[0].nonemployment[0].value |
      | users[0].nonemployment[i].value | 1000000 | users[0].nonemployment[0].value |
      | has_special_training | False | |
      | has_disabilities | False | |
      | x.selected_types['rent'] | True | users[0].expenses.selected_types |
      | x[i].value | 1000000 | users[0].expenses[0].value |
      | x[i].times_per_year | 12 | users[0].expenses[0].value |
      | user_owns_home | False | |
      | user_owns_car | False | |
      | users[0].accounts.there_are_any | False | |
      | user_owns_property | False | |
      | user_has_debts | False | |
      | fees['Filing fee'].waive | True | |
      | fees['Filing fee'].amount | 315 | |
      | acknowledge_disclaimers['user_agrees_to_disclaimers'] | True | |
      | signature_choice | this_device | |
      | signature_date | today | |
      | users[0].signature | | user[0].signature |
    Then I tap the "#efile-button" element
    # And I tap to continue

  @sp6a_interview @si5 @efile @slow
  Scenario: sp6a w/e-filing from appeals, to end
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 40

  @sp6a_interview @si6 @efile
  Scenario: sp6a again?
    Given I start the interview at "SP6A.yml"