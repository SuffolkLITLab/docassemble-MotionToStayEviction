Feature: Get through SP6A interview

  Runs the `SP6A.yml` interview to completion, with several different variations.

  @sp6a_interview @si1 @fast
  Scenario: sp6a interview starts
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 30
    And I set the variable "acknowledged_information_use['I accept the terms of use.']" to "True"
    And I tap to continue

  @sp6a_interview @si2
  Scenario: sp6a interview through to end, no e-filing
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 40
    And I get to the question id "download form" with this data:
      | var | value | trigger |
      | acknowledged_information_use['I accept the terms of use.'] | True | |
      | user_wants_efile | False | |
      | users[0].name.first | Bob | |
      | users[0].name.last | Ma | |
      | users[0].email | example@example.com | |
      | users[0].address.address | 123 Fake St | |
      | users[0].address.city | Boston | |
      | users[0].address.state | MA | |
      | users[0].address.zip | 02122 | |
      | users[0].phone_number | 123-456-7890 | |
      | user_needs_interpreter | False ||
      | plaintiff_name | Brandon Man | |
      | defendant_name | Bob Ma | |
      | forty_eight_hour_notice | False | |
      | housing_court | all_courts[45] | |
      | lower_court_case.docket_number | 1234567 | |
      | lower_court_case.judgment_date | 06/20/2022 | |
      | lower_court_case.judge | Judge Ben | |
      | date_housing_court_denied_motion_to_stay | 06/20/2022 | |
      | housing_court_denying_order_text | Some reason, I'm sure it's very important | |
      | date_notice_of_appeal_filed | 06/20/2022 | |
      | is_initial_filing | True | |
      | x.has_exhibits | False | exhibits.exhibits.has_exhibits |
      | no_record_statement | True | |
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
      | signature_date | today | |
      | users[0].signature | | user[0].signature |

  @sp6a_interview @si3 @efile @slow
  Scenario: sp6a interview through to end, with e-filing
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 40
    And I get to the question id "eFile Login" with this data:
      | var | value | trigger |
      | acknowledged_information_use['I accept the terms of use.'] | True | |
      | is_initial_filing | True | |
      | user_wants_efile | True | |
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
      | user_needs_interpreter | False ||
      | plaintiff_name | Brandon Man | |
      | defendant_name | Bob Ma | |
      | housing_court | all_courts[45] | |
      | lower_court_case.docket_number | 1234567 | |
      | lower_court_case.judgment_date | 06/20/2022 | |
      | lower_court_case.judge | Judge Ben | |
      | date_housing_court_denied_motion_to_stay | 06/20/2022 | |
      | housing_court_denying_order_text | Some reason, I'm sure it's very important | |
      | date_notice_of_appeal_filed | 06/20/2022 | |
      | x.has_exhibits | False | exhibits.exhibits.has_exhibits |
      | no_record_statement | True | |
      | x.document_type | 6586 | motion_to_stay_bundle.document_type |
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
      | fees['Filing fee'].waive | True | |
      | fees['Filing fee'].amount | 315 | |
      | signature_date | today | |
      | users[0].signature | | user[0].signature |
    Then I click the efile-button element
    And I tap to continue


  @sp6a_interview @si4 @efile @slow
  Scenario: sp6a interview through to end, with e-filing, from existing appeals case
    Given I start the interview at "SP6A.yml"
    And the maximum seconds for each Step in this Scenario is 40