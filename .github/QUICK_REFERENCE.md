# ALKiln Quick Reference

## Common Gherkin Test Steps

### Starting Tests
```gherkin
Given I start the interview at "filename"           # Load an interview
```

### Setting Values
```gherkin
And I set the var "variable_name" to "value"       # Set any variable
And I set the var "age" to "25"
And I set the var "is_employed" to "True"
```

### Navigation
```gherkin
And I continue                                      # Click continue button
And I click the button for "variable_name"         # Click specific button
```

### Assertions (Check Results)
```gherkin
Then I should see the phrase "expected text"       # Look for text
Then I should NOT see the phrase "should not appear"
```

### Forms & Input
```gherkin
And I set the var "client_name" to "John Doe"
And I set the var "email" to "john@example.com"
And I set the var "state" to "Massachusetts"
```

### Boolean Values
```gherkin
And I set the var "eligible" to "True"
And I set the var "has_dependents" to "False"
```

---

## Complete Example Test

```gherkin
Feature: Intake Form Tests

Scenario: Complete intake form successfully
  Given I start the interview at "intake_form"
  # See first question
  Then I should see the phrase "Client name"
  # Fill in information
  And I set the var "client_name" to "Jane Smith"
  And I set the var "phone_number" to "617-555-1234"
  And I set the var "email" to "jane@example.com"
  # Go to next page
  And I continue
  # Verify second question appears
  Then I should see the phrase "Case type"
  And I set the var "case_type" to "Divorce"
  And I continue
  # Check success message
  Then I should see the phrase "Thank you for completing the intake form"
```

---

## Interview File Naming

Use **just the filename** without the `.yml` extension:
- ✅ CORRECT: `Given I start the interview at "client_intake"`
- ❌ WRONG: `Given I start the interview at "client_intake.yml"`
- ❌ WRONG: `Given I start the interview at "docassemble.demo:data/questions/hello.yml"`

---

## Where to Get Help

| Question | Answer |
|---|---|
| What Gherkin steps are available? | [ALKiln Step Documentation](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/) |
| How do I write YAML interviews? | [Docassemble Documentation](https://docassemble.org/docs/interview.html) |
| How does Gherkin syntax work? | [Cucumber/Gherkin Guide](https://cucumber.io/docs/gherkin/) |
| Tests are failing, what do I do? | See README.md Troubleshooting section |

---

## Debugging Tips

### Check what your interview actually shows
```gherkin
# Use this to see what text appears when you hit a problem
Then I should see the phrase "anything will work"  # This will show actual page content in error
```

### Test step by step
```gherkin
# Break complex tests into smaller pieces to find where it breaks
Given I start the interview at "form"
And I continue                     # Test just this
Then I should see the phrase "Page 2"

# If that passes, go to next step:
Given I start the interview at "form"
And I continue
And I set the var "name" to "John"  # Test this
And I continue
Then I should see the phrase "Page 3"
```

### Variable names matter
```gherkin
# Your variable names MUST match your YAML exactly
# Check spelling, capitalization, underscores, everything!
And I set the var "client_name" to "John"  ← Make sure "client_name" exists in your YAML
```

---

## Test File Location
- Must be named: `test_interviews.feature`
- Must be in root directory: `/test_interviews.feature`
- One test file handles all interview tests
