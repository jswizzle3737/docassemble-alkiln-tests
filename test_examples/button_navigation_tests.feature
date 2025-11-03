# Button and Navigation Test Scenarios
# Patterns for testing button clicks and navigation elements

Feature: Button Navigation Tests

# Pattern: Click specific button by variable name
Scenario: User clicks button to proceed
  Given I start the interview at "button_navigation"
  And I continue
  Then I should see the phrase "Choose an option"
  And I click the button for "option_a"
  Then I should see the phrase "You selected Option A"

# Pattern: Multiple button clicks in sequence
Scenario: User navigates using multiple buttons
  Given I start the interview at "multi_button_form"
  And I continue
  And I click the button for "add_person"
  Then I should see the phrase "Person added"
  And I click the button for "add_another"
  Then I should see the phrase "Add another person"
  And I click the button for "finish"
  Then I should see the phrase "Complete"

# Pattern: Testing button alternatives
Scenario: User selects yes button
  Given I start the interview at "yes_no_question"
  And I continue
  And I click the button for "has_attorney"
  And I set the var "has_attorney" to "True"
  And I continue
  Then I should see the phrase "Attorney information"

Scenario: User selects no button
  Given I start the interview at "yes_no_question"
  And I continue
  And I click the button for "has_attorney"
  And I set the var "has_attorney" to "False"
  And I continue
  Then I should see the phrase "Proceed without attorney"

# Pattern: Back button navigation (if supported)
Scenario: User goes back and changes answer
  Given I start the interview at "editable_form"
  And I set the var "first_answer" to "Initial value"
  And I continue
  Then I should see the phrase "Second question"
  # Note: Back navigation depends on interview setup
  # Add back button steps if your interview supports it
