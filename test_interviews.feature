Feature: Interviews load

Scenario: The main interview loads
  Given I start the interview at "docassemble.demo:data/questions/hello.yml"

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