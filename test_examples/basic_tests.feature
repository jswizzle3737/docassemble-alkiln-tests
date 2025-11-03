# Basic Test Scenarios
# Copy these patterns to your main test_interviews.feature file

Feature: Basic Interview Tests

# Pattern: Simple smoke test - just verify interview loads
Scenario: Interview loads successfully
  Given I start the interview at "your_interview_name"

# Pattern: Basic navigation - load and continue
Scenario: User can navigate through interview
  Given I start the interview at "your_interview_name"
  And I continue
  Then I should see the phrase "Expected text on next page"

# Pattern: Simple form submission
Scenario: User submits basic form
  Given I start the interview at "intake_form"
  And I set the var "client_name" to "John Doe"
  And I continue
  Then I should see the phrase "Form received"

# Pattern: Multiple field form
Scenario: User completes contact information
  Given I start the interview at "contact_form"
  And I set the var "first_name" to "Jane"
  And I set the var "last_name" to "Smith"
  And I set the var "email" to "jane@example.com"
  And I set the var "phone" to "555-1234"
  And I continue
  Then I should see the phrase "Contact information saved"
