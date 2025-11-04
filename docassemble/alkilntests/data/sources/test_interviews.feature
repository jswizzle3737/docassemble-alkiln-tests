Feature: Interview Tests

# ✅ EXAMPLE TEST - This tests the built-in test.yml interview
Scenario: Test interview completes successfully
  Given I start the interview at "test"
  And I continue
  Then I should see the phrase "Thank you for testing"

# If the above fails, try these alternatives:
# Scenario: Basic connection test  
#   Given I start the interview at "docassemble.playground1:hello.yml"
#
# Scenario: Simple test
#   Given I go to the interview list

# Additional test scenarios can be added here
# Replace "docassemble.demo:data/questions/hello.yml" with your actual interview filename

# Example additional tests:
# Scenario: User can complete the interview
#   Given I start the interview at "docassemble.demo:data/questions/hello.yml"
#   And I wait 2 seconds
#   And I continue
#   And I wait 2 seconds
#   And I set the var "user_name" to "Test User"
#   And I continue
#   Then I should see the phrase "Thank you"

# Scenario: Required field validation works
#   Given I start the interview at "docassemble.demo:data/questions/hello.yml"
#   And I continue
#   Then I should see the phrase "This field is required"