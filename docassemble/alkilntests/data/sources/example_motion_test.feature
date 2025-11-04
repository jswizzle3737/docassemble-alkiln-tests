Feature: Example Motion to Continue Tests
  Automated tests for the example Assembly Line motion form

Scenario: User completes motion with all required fields
  Given I start the interview at "example_motion"
  # Intro screen
  And I continue
  # User name
  And I set the var "users[0].name.first" to "Jane"
  And I set the var "users[0].name.last" to "Smith"
  And I continue
  # User address
  And I set the var "users[0].address.address" to "123 Main Street"
  And I set the var "users[0].address.city" to "Boston"
  And I set the var "users[0].address.state" to "MA"
  And I set the var "users[0].address.zip" to "02108"
  And I continue
  # Phone number
  And I set the var "users[0].phone_number" to "617-555-0123"
  And I continue
  # Email
  And I set the var "users[0].email" to "jane.smith@example.com"
  And I continue
  # Other party
  And I set the var "other_parties[0].name.first" to "John"
  And I set the var "other_parties[0].name.last" to "Doe"
  And I continue
  # Court - using text field version for testing
  And I set the var "trial_court" to "Boston Municipal Court"
  And I continue
  # Docket number
  And I set the var "docket_number" to "2023-CV-12345"
  And I continue
  # Motion reason
  And I set the var "motion_reason" to "I need more time to gather evidence and prepare my case for trial"
  And I continue
  # Signature
  And I sign
  And I continue
  # Verify download screen
  Then I should see the phrase "Your Motion to Continue is ready"
  And I should see the phrase "Jane Smith"
  And I should see the phrase "John Doe"
  And I should see the phrase "Boston Municipal Court"
  And I should see the phrase "2023-CV-12345"

Scenario: Motion using story table (efficient method)
  Given I start the interview at "example_motion"
  And I continue
  And I get to the question id "signature" with this data:
    | var | value | trigger |
    | users[0].name.first | Alice | |
    | users[0].name.last | Johnson | |
    | users[0].address.address | 456 Oak Avenue | |
    | users[0].address.city | Springfield | |
    | users[0].address.state | MA | |
    | users[0].address.zip | 01101 | |
    | users[0].phone_number | 413-555-7890 | |
    | users[0].email | alice.johnson@example.com | |
    | other_parties[0].name.first | Robert | |
    | other_parties[0].name.last | Williams | |
    | trial_court | Springfield District Court | |
    | docket_number | 2023-CV-54321 | |
    | motion_reason | Medical emergency requires more time | users[0].signature |
  And I sign
  And I continue
  Then I should see the phrase "Alice Johnson"
  And I should see the phrase "Robert Williams"
  And I should see the phrase "Springfield District Court"

Scenario: Required fields are validated
  Given I start the interview at "example_motion"
  And I continue
  # Try to skip required name field
  And I continue
  Then I will be told an answer is invalid

Scenario: Email validation works correctly
  Given I start the interview at "example_motion"
  And I continue
  And I get to the question id "email" with this data:
    | var | value | trigger |
    | users[0].name.first | Test | |
    | users[0].name.last | User | |
    | users[0].address.address | 100 Test St | |
    | users[0].address.city | Boston | |
    | users[0].address.state | MA | |
    | users[0].address.zip | 02108 | |
    | users[0].phone_number | 617-555-0000 | |
  # Try invalid email
  And I set the var "users[0].email" to "invalid-email"
  And I continue
  Then I will be told an answer is invalid
  # Fix with valid email
  And I set the var "users[0].email" to "test.user@example.com"
  And I continue
  # Should proceed successfully
  Then I should NOT see the phrase "This field is required"
