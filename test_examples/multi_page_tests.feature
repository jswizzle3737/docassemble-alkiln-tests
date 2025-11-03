# Multi-Page Interview Test Scenarios
# Patterns for testing complex, multi-step interviews

Feature: Multi-Page Interview Tests

# Pattern: Linear multi-page flow
Scenario: User completes three-page interview
  Given I start the interview at "application"
  # Page 1: Personal info
  Then I should see the phrase "Personal information"
  And I set the var "name" to "John Doe"
  And I set the var "date_of_birth" to "01/15/1980"
  And I continue
  # Page 2: Contact info
  Then I should see the phrase "Contact information"
  And I set the var "email" to "john@example.com"
  And I set the var "phone" to "555-1234"
  And I continue
  # Page 3: Review and submit
  Then I should see the phrase "Review your information"
  And I should see the phrase "John Doe"
  And I continue
  Then I should see the phrase "Application submitted"

# Pattern: Multi-step with validation
Scenario: User navigates through validated pages
  Given I start the interview at "validated_form"
  And I set the var "email" to "valid@example.com"
  And I continue
  Then I should see the phrase "Address information"
  And I set the var "street" to "123 Main St"
  And I set the var "city" to "Boston"
  And I set the var "zip_code" to "02134"
  And I continue
  Then I should see the phrase "Confirmation"

# Pattern: Interview with review page
Scenario: User reviews and confirms information
  Given I start the interview at "application_with_review"
  And I set the var "applicant_name" to "Jane Smith"
  And I continue
  And I set the var "case_number" to "12345"
  And I continue
  # Review page shows all entered data
  Then I should see the phrase "Please review"
  And I should see the phrase "Jane Smith"
  And I should see the phrase "12345"
  And I continue
  Then I should see the phrase "Submitted successfully"
