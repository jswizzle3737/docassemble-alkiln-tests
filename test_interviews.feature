# =============================================================================
# Your Interview Tests
# =============================================================================
# Write your interview tests here using Gherkin syntax.
# See test_examples/ directory for categorized test patterns you can copy.
# See GETTING_STARTED.md and README.md for detailed guidance.
#
# 💡 TIP: Look at test_examples/ directory for ready-to-use patterns:
#    - basic_tests.feature - Simple forms and navigation
#    - conditional_logic_tests.feature - Branching logic
#    - multi_page_tests.feature - Complex multi-step interviews
#    - button_navigation_tests.feature - Button clicks
#    - validation_tests.feature - Error handling and validation
#
# 📚 Full ALKiln documentation:
# https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/
# =============================================================================

Feature: Interview Tests

  # =============================================================================
  # SMOKE TESTS - Verify basic functionality
  # =============================================================================
  
  Scenario: Interview loads successfully
    Given I start the interview at "test"
    And I continue
    Then I should see the phrase "Thank you"

  # =============================================================================
  # YOUR CUSTOM TESTS - Add your interview-specific tests below
  # =============================================================================
  
  # Example: Uncomment and customize these patterns for your interviews
  
  # Scenario: User completes intake form
  #   Given I start the interview at "your_interview_name"
  #   And I set the var "client_name" to "John Doe"
  #   And I set the var "client_email" to "john@example.com"
  #   And I continue
  #   Then I should see the phrase "Form submitted"
  
  # Scenario: Eligible user proceeds to application
  #   Given I start the interview at "eligibility_check"
  #   And I set the var "income_level" to "50000"
  #   And I set the var "has_dependents" to "True"
  #   And I continue
  #   Then I should see the phrase "You are eligible"
  
  # =============================================================================
  # More test patterns available in test_examples/ directory
  # Copy and customize patterns that match your interview structure
  # =============================================================================
