# Test Examples Directory

This directory contains categorized test scenario examples to help you write comprehensive tests for your docassemble interviews.

## 📁 Available Test Pattern Files

### `basic_tests.feature`
**Use for:** Initial smoke tests, simple form submissions, basic navigation
- Interview loading verification
- Single-page forms
- Basic multi-field forms
- Simple continue/submit flows

### `conditional_logic_tests.feature`
**Use for:** Testing branching logic and decision trees
- Boolean (yes/no) branching
- Multiple choice selection paths
- State or jurisdiction-based logic
- Eligibility screening flows

### `multi_page_tests.feature`
**Use for:** Complex multi-step interviews
- Linear page-by-page flows
- Review and confirmation pages
- Data persistence across pages
- Multi-step application processes

### `button_navigation_tests.feature`
**Use for:** Button clicks and navigation elements
- Specific button targeting
- Add/remove dynamic elements
- Yes/No button selections
- Multiple button sequences

### `validation_tests.feature`
**Use for:** Form validation and error handling
- Required field validation
- Format validation (email, phone, date)
- Numeric range validation
- Conditional validation rules

## 🚀 How to Use These Examples

### 1. Copy Relevant Scenarios
Find scenarios that match your interview structure and copy them to your main `test_interviews.feature` file:

```bash
# Copy specific patterns you need
# Edit and customize them with your actual interview names and variables
```

### 2. Customize for Your Interview
Replace placeholder values with your actual:
- Interview filenames
- Variable names (from your YAML files)
- Expected text phrases
- Field values

**Example transformation:**
```gherkin
# From example file:
Scenario: User submits basic form
  Given I start the interview at "intake_form"
  And I set the var "client_name" to "John Doe"
  
# Your customized version:
Scenario: User submits rental assistance form
  Given I start the interview at "rental_assistance"
  And I set the var "tenant_name" to "Jane Smith"
```

### 3. Mix and Match Patterns
Combine patterns from different files to test complex scenarios:

```gherkin
Scenario: Complete eligibility check with validation
  # Start with basic pattern
  Given I start the interview at "eligibility_form"
  # Add validation pattern
  And I set the var "income" to "50000"
  # Add conditional logic pattern
  And I set the var "has_dependents" to "True"
  # Continue with multi-page pattern
  And I continue
  Then I should see the phrase "Dependent information"
```

## 📋 Best Practices

### Start Simple
1. Begin with `basic_tests.feature` patterns
2. Verify your interview loads
3. Test one path through your interview
4. Gradually add more complex scenarios

### Test One Thing at a Time
Each scenario should test a specific behavior:
- ✅ Good: "User with dependents sees additional questions"
- ❌ Too broad: "User completes entire application"

### Use Descriptive Scenario Names
```gherkin
# ✅ Clear and specific
Scenario: Massachusetts resident receives MA-specific forms

# ❌ Vague
Scenario: Test state selection
```

### Keep Scenarios Independent
Each scenario should:
- Start fresh (with `Given I start the interview`)
- Not depend on previous scenarios
- Be runnable in any order

## 🎯 Choosing the Right Pattern

| Your Interview Has... | Use This Example File |
|---|---|
| One or two simple questions | `basic_tests.feature` |
| Yes/No branches with different paths | `conditional_logic_tests.feature` |
| Multiple pages of questions | `multi_page_tests.feature` |
| Buttons to add/remove items | `button_navigation_tests.feature` |
| Required fields or format validation | `validation_tests.feature` |

## 💡 Tips

### Finding Variable Names
Look in your interview YAML file:
```yaml
question: What is your name?
fields:
  - Name: client_name  ← Use this in your test
```

### Finding Expected Text
Copy exact phrases from your YAML:
```yaml
subquestion: |
  Thank you for your submission  ← Use this phrase
```

### Testing Multiple Paths
Create separate scenarios for each path through your interview:
```gherkin
Scenario: Eligible user path
  # ... steps for eligible users

Scenario: Ineligible user path
  # ... steps for ineligible users
```

## 📚 Learn More

- **Main Documentation:** See `README.md` for setup and usage
- **ALKiln Steps:** [Complete step reference](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/)
- **Troubleshooting:** See `TROUBLESHOOTING.md` for common issues
- **Quick Reference:** See `.github/QUICK_REFERENCE.md` for syntax cheatsheet

## 🤝 Contributing Your Patterns

If you develop useful test patterns not covered here, consider:
1. Adding them to the appropriate example file
2. Documenting the use case
3. Sharing with the community

Happy testing! 🧪
