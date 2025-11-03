# Write your interview tests here using Gherkin syntax
# See GETTING_STARTED.md for examples and guidance

Feature: Interview Tests

# ✅ EXAMPLE TEST - Replace with your own!
Scenario: Example test scenario
  Given I start the interview at "test"
  And I continue
  Then I should see the phrase "Thank you"

# 📝 COMMON TEST PATTERNS (uncomment and modify as needed)

# Pattern 1: Simple form submission
# Scenario: User submits intake form
#   Given I start the interview at "intake_form"
#   And I set the var "client_name" to "John Doe"
#   And I continue
#   Then I should see the phrase "Form received"

# Pattern 2: Multi-step interview
# Scenario: Complete divorce petition
#   Given I start the interview at "divorce_papers"
#   And I continue
#   Then I should see the phrase "Spouse information"
#   And I set the var "spouse_name" to "Jane Smith"
#   And I continue
#   Then I should see the phrase "Property division"

# Pattern 3: Button clicks and navigation
# Scenario: Navigate using buttons
#   Given I start the interview at "quiz"
#   And I continue
#   Then I should see the phrase "Question 1"
#   And I click the button for "answer_a"
#   And I continue
#   Then I should see the phrase "Correct!"

# Pattern 4: Boolean variables
# Scenario: Handle yes/no questions
#   Given I start the interview at "screening"
#   And I set the var "eligible_to_file" to "True"
#   And I continue
#   Then I should see the phrase "Proceed to filing"

# Pattern 5: Multiple variables
# Scenario: Complex form with multiple fields
#   Given I start the interview at "application"
#   And I set the var "first_name" to "John"
#   And I set the var "last_name" to "Doe"
#   And I set the var "phone_number" to "555-1234"
#   And I set the var "email" to "john@example.com"
#   And I continue
#   Then I should see the phrase "Application complete"

# 📚 For complete ALKiln step documentation, see:
# https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/
