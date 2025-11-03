# Validation and Error Handling Test Scenarios
# Patterns for testing form validation and error messages

Feature: Validation and Error Tests

# Pattern: Required field validation
Scenario: Form requires name field
  Given I start the interview at "validated_form"
  # Try to continue without filling required field
  And I continue
  Then I should see the phrase "This field is required"

# Pattern: Email format validation
Scenario: Invalid email shows error
  Given I start the interview at "contact_form"
  And I set the var "email" to "invalid-email"
  And I continue
  Then I should see the phrase "Please enter a valid email"

Scenario: Valid email is accepted
  Given I start the interview at "contact_form"
  And I set the var "email" to "valid@example.com"
  And I continue
  Then I should NOT see the phrase "Please enter a valid email"

# Pattern: Numeric validation
Scenario: Age must be a number
  Given I start the interview at "age_verification"
  And I set the var "age" to "not-a-number"
  And I continue
  Then I should see the phrase "Please enter a valid age"

Scenario: Valid age is accepted
  Given I start the interview at "age_verification"
  And I set the var "age" to "25"
  And I continue
  Then I should NOT see the phrase "Please enter a valid age"

# Pattern: Conditional validation
Scenario: If option selected, additional field required
  Given I start the interview at "conditional_form"
  And I set the var "has_spouse" to "True"
  And I continue
  # Now spouse_name should be required
  And I continue
  Then I should see the phrase "Spouse name is required"

# Pattern: Date validation
Scenario: Future date not allowed for birth date
  Given I start the interview at "birth_date_form"
  And I set the var "date_of_birth" to "12/31/2099"
  And I continue
  Then I should see the phrase "Birth date cannot be in the future"
