# Conditional Logic Test Scenarios
# Use these patterns to test branching logic in interviews

Feature: Conditional Logic Tests

# Pattern: Boolean decision branching
Scenario: Eligible user sees next steps
  Given I start the interview at "eligibility_checker"
  And I set the var "is_eligible" to "True"
  And I continue
  Then I should see the phrase "Proceed with application"

Scenario: Ineligible user sees rejection
  Given I start the interview at "eligibility_checker"
  And I set the var "is_eligible" to "False"
  And I continue
  Then I should see the phrase "Unfortunately, you are not eligible"

# Pattern: Multiple choice branching
Scenario: User selects option A
  Given I start the interview at "case_type_selector"
  And I set the var "case_type" to "Divorce"
  And I continue
  Then I should see the phrase "Divorce petition"

Scenario: User selects option B
  Given I start the interview at "case_type_selector"
  And I set the var "case_type" to "Custody"
  And I continue
  Then I should see the phrase "Custody petition"

# Pattern: State-based logic
Scenario: Massachusetts resident gets MA forms
  Given I start the interview at "jurisdiction_selector"
  And I set the var "state" to "Massachusetts"
  And I continue
  Then I should see the phrase "Massachusetts courts"
  And I should NOT see the phrase "California courts"
