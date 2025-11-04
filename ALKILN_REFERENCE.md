# ALKiln Testing Framework - Complete Reference

## 🎯 What is ALKiln?

**ALKiln** (Assembly Line Kiln) is an automated testing framework specifically designed for docassemble interviews. It simulates real user interactions with your forms, checking that everything works correctly.

### Technology Stack
- **Cucumber** - Behavior-driven testing (Gherkin syntax)
- **Puppeteer** - Headless Chrome browser automation
- **Chai** - Assertion library for validation

### You're Already Using It!
Your repository uses ALKiln through **GitHub Actions**:
- Every push/PR triggers tests automatically
- Uses: `SuffolkLITLab/ALKiln@v5`
- Configured in: `.github/workflows/alkiln_tests.yml`

---

## 📝 Complete ALKiln Step Reference

### 🚀 Starting an Interview

```gherkin
# Basic start
Given I start the interview at "interview_name"

# Start with specific file path
Given I start the interview at "docassemble.PackageName:data/questions/file.yml"

# Start from playground
Given I start the interview at "docassemble.playground1:my_interview.yml"
```

### ⏱️ Timing and Waits

```gherkin
# Wait specific time
Given I wait 5 seconds

# Change timeout for all steps
Given the maximum seconds for each Step is 200

# Wait at specific point (deprecated, use above)
And I wait 2 seconds
```

### 🔐 Authentication

```gherkin
# Log in with credentials
Given I log in with the email "user@example.com" and password "password123"

# Using GitHub secrets (recommended)
Given I log in with the email "user@example.com" and password the GitHub secret "USER_PASSWORD"
```

### ▶️ Navigation

```gherkin
# Continue to next page
And I continue

# Alternative forms
And I tap to continue
When I tap to continue
```

### ✍️ Setting Variables

#### Basic Variable Setting

```gherkin
# Text field
And I set the var "user_name" to "John Doe"

# Number (as string)
And I set the var "age" to "25"

# Boolean
And I set the var "is_eligible" to "True"
And I set the var "is_minor" to "False"

# Using GitHub secrets
And I set the var "api_key" to the GitHub secret "API_KEY"
```

#### Special Variable Types

```gherkin
# Date (use special syntax)
And I set the var "birth_date" to "today"
And I set the var "deadline" to "today + 30"
And I set the var "historic_date" to "today - 3650"

# Signature
And I sign
When I sign

# Name fields
And I set the name of "users[0]" to "Jane Smith"

# Address fields
And I set the address of "users[0]" to "120 Tremont Street, Boston, MA 02108"
```

#### Advanced: Story Tables

**Most flexible way to fill forms:**

```gherkin
And I get to the question id "final_page" with this data:
  | var | value | trigger |
  | users[0].name.first | Jane | |
  | users[0].name.last | Smith | |
  | users[0].address.address | 123 Main St | |
  | users[0].birthdate | today - 9125 | users[0].signature |
  | other_parties[0].name.first | John | |
  | docket_number | 2023-CV-12345 | |
```

**Notes:**
- Stops when it reaches the question with `question id: final_page`
- `trigger` column forces variable to be set (useful for signatures)
- Use `|` for empty trigger

### 📸 Screenshots

```gherkin
# Take screenshot at current point
Then I take a screenshot

# Screenshots are saved in test artifacts
```

### ✅ Assertions (Checking Results)

#### Text Verification

```gherkin
# Check for text presence
Then I should see the phrase "Thank you"
Then I SHOULD see the phrase "Application complete"

# Check text absence
Then I should NOT see the phrase "Error"

# Case sensitive
Then I should see the phrase "John Smith"  # Won't match "john smith"
```

#### Page Verification

```gherkin
# Verify specific page reached
Then the question id should be "download_screen"

# Check for validation errors
Then I will be told an answer is invalid
```

#### Accessibility Testing

```gherkin
# Check page for WCAG issues
Then I check the page for accessibility issues

# This checks for common accessibility problems
```

### 📄 File Operations

#### Downloads

```gherkin
# Download a file
Then I download "motion_to_continue.pdf"

# File gets saved to test artifacts
```

#### PDF Comparison

```gherkin
# Compare PDFs for regression testing
Then I expect the baseline PDF "baseline_motion.pdf" and new PDF "motion_to_continue.pdf" to be the same

# Great for catching unintended document changes
```

#### Uploads

```gherkin
# Upload file to docassemble
And I upload "evidence.pdf" to "evidence_file"

# File must exist in test fixtures
```

### 🔧 Special Actions

#### Buttons and Clicks

```gherkin
# Click specific button
And I click the button for "continue_button"

# For multiple choice or radio buttons
And I set the var "choice" to "option_a"
```

#### Comboboxes and Selects

```gherkin
# Regular dropdown
And I set the var "state" to "Massachusetts"

# Searchable combobox
And I set the var "trial_court" to "Boston Municipal Court"
```

---

## 🎯 Common Testing Patterns

### Pattern 1: Simple Form Completion

```gherkin
Feature: Simple Contact Form

Scenario: User submits contact information
  Given I start the interview at "contact_form"
  And I set the var "user_name" to "Alice Johnson"
  And I set the var "user_email" to "alice@example.com"
  And I set the var "message" to "I need help with my case"
  And I continue
  Then I should see the phrase "Thank you, Alice Johnson"
  And I should see the phrase "We will contact you at alice@example.com"
```

### Pattern 2: Assembly Line Form

```gherkin
Feature: Court Motion Form

Scenario: Complete motion to continue
  Given I start the interview at "ma_motion_continue"
  # Use story table for efficiency
  And I get to the question id "signature" with this data:
    | var | value | trigger |
    | users[0].name.first | Jane | |
    | users[0].name.last | Smith | |
    | users[0].address.address | 123 Main St | |
    | users[0].address.city | Boston | |
    | users[0].address.state | MA | |
    | users[0].address.zip | 02108 | |
    | other_parties[0].name.first | John | |
    | other_parties[0].name.last | Doe | |
    | docket_number | 2023-CV-12345 | |
    | motion_reason | Need more time | users[0].signature |
  And I sign
  And I continue
  Then I should see the phrase "Motion to Continue"
  And I download "motion_to_continue.pdf"
```

### Pattern 3: Multi-Step Interview with Branching

```gherkin
Feature: Eligibility Screening

Scenario: Eligible user completes application
  Given I start the interview at "eligibility_check"
  # Screening questions
  And I set the var "has_case" to "True"
  And I continue
  And I set the var "income_level" to "below_150_percent"
  And I continue
  # Should reach application
  Then I should see the phrase "You are eligible"
  # Complete application
  And I set the var "applicant_name" to "Bob Lee"
  And I continue
  Then I should see the phrase "Application submitted"

Scenario: Ineligible user sees rejection
  Given I start the interview at "eligibility_check"
  And I set the var "has_case" to "False"
  And I continue
  Then I should see the phrase "Unfortunately, you are not eligible"
  And I should NOT see the phrase "Application"
```

### Pattern 4: Testing with Authentication

```gherkin
Feature: Admin Dashboard

Scenario: Admin can access dashboard
  Given I log in with the email "admin@example.com" and password the GitHub secret "ADMIN_PASSWORD"
  And I start the interview at "admin_dashboard"
  Then I should see the phrase "Welcome, Administrator"
  And I should see the phrase "Manage Users"
```

### Pattern 5: File Upload and Processing

```gherkin
Feature: Document Upload

Scenario: User uploads evidence
  Given I start the interview at "evidence_upload"
  And I set the var "case_number" to "2023-CV-001"
  And I continue
  And I upload "evidence_document.pdf" to "evidence_file"
  And I continue
  Then I should see the phrase "File uploaded successfully"
  And I should see the phrase "evidence_document.pdf"
```

### Pattern 6: Validation Testing

```gherkin
Feature: Form Validation

Scenario: Required fields must be filled
  Given I start the interview at "contact_form"
  # Try to continue without filling required fields
  And I continue
  Then I will be told an answer is invalid

Scenario: Email format validation
  Given I start the interview at "contact_form"
  And I set the var "email" to "invalid-email"
  And I continue
  Then I will be told an answer is invalid
  # Fill correctly
  And I set the var "email" to "valid@example.com"
  And I continue
  Then I should see the phrase "Thank you"
```

### Pattern 7: PDF Regression Testing

```gherkin
Feature: Document Generation

Scenario: PDF matches baseline
  Given I start the interview at "divorce_complaint"
  And I get to the question id "download" with this data:
    | var | value | trigger |
    | petitioner_name | Jane Doe | |
    | respondent_name | John Doe | |
    | marriage_date | today - 3650 | |
    | grounds | irreconcilable | |
  And I continue
  Then I download "divorce_complaint.pdf"
  And I expect the baseline PDF "baseline_divorce_complaint.pdf" and new PDF "divorce_complaint.pdf" to be the same
```

---

## 🔐 Using GitHub Secrets in Tests

### Why Use Secrets?

- Protect passwords, API keys, and sensitive data
- Keep credentials out of code
- Share tests safely in public repos

### How to Use

1. **Add secret to GitHub** (already done for SERVER_URL and API_KEY)
2. **Reference in test:**

```gherkin
Given I log in with the email "user@example.com" and password the GitHub secret "USER_PASSWORD"

And I set the var "api_key" to the GitHub secret "EXTERNAL_API_KEY"
```

### Available Secrets in Your Repo

```gherkin
# Already configured:
the GitHub secret "SERVER_URL"                        # Docassemble server
the GitHub secret "DOCASSEMBLE_DEVELOPER_API_KEY"    # API authentication

# Add more as needed in GitHub Settings → Secrets
```

---

## 🎨 Advanced Features

### Story Tables in Detail

Story tables let you fill multiple fields before continuing:

```gherkin
And I get to the question id "final_screen" with this data:
  | var | value | trigger |
  | field1 | value1 | |
  | field2 | value2 | |
  | field3 | value3 | trigger_var |
```

**How it works:**
1. Sets all variables in order
2. Continues through pages automatically
3. Stops at question with ID "final_screen"
4. `trigger` column forces specific variable to be set (useful for signatures)

**When to use:**
- Long forms with many fields
- Cleaner than many individual steps
- Better for Assembly Line forms

### Accessibility Testing

```gherkin
# Check current page
Then I check the page for accessibility issues
```

**What it checks:**
- Missing alt text on images
- Insufficient color contrast
- Missing form labels
- Keyboard navigation issues
- ARIA attribute problems

### Screenshot Debugging

```gherkin
# Take screenshot at any point
Then I take a screenshot

# Screenshots saved in:
# - GitHub Actions: Test artifacts
# - Local runs: screenshots/ directory
```

**Use cases:**
- Debug failing tests
- Document expected behavior
- Visual regression testing

---

## 📁 Test File Organization

### Basic Structure

```gherkin
Feature: Feature Name
  Description of what's being tested

Scenario: Specific test case
  Given [setup step]
  When [action step]
  Then [verification step]

Scenario: Another test case
  Given [setup step]
  And [additional setup]
  When [action step]
  Then [verification step]
  And [additional verification]
```

### Multiple Features

Create separate `.feature` files for different form types:

```
docassemble/alkilntests/data/sources/
├── intake_forms.feature
├── court_motions.feature
├── eligibility_screening.feature
└── admin_features.feature
```

### Scenario Organization

```gherkin
Feature: Motion to Continue

# Happy path - most common use case
Scenario: Attorney files motion successfully
  [steps...]

# Edge cases
Scenario: Motion with urgent request
  [steps...]

Scenario: Motion without attorney
  [steps...]

# Error cases
Scenario: Required fields validation
  [steps...]
```

---

## 🐛 Debugging Tips

### When Tests Fail

1. **Check the error message** in GitHub Actions logs
2. **Look for screenshots** in test artifacts
3. **Run interview manually** to verify it works
4. **Check variable names** match exactly
5. **Verify phrase text** is exact (case-sensitive)

### Common Issues

#### "Interview not found"
```gherkin
# ❌ Wrong
Given I start the interview at "my_interview.yml"

# ✅ Correct
Given I start the interview at "my_interview"
```

#### "Variable not set"
```gherkin
# ❌ Wrong (typo)
And I set the var "user_name" to "John"

# ✅ Correct (matches YAML)
And I set the var "users_name" to "John"
```

#### "Phrase not found"
```gherkin
# ❌ Wrong (partial match)
Then I should see the phrase "Thank you"

# ✅ Correct (exact match from interview)
Then I should see the phrase "Thank you for your submission"
```

#### "Timeout"
```gherkin
# Add more time
Given the maximum seconds for each Step is 300

# Or add waits
And I wait 5 seconds
And I continue
```

---

## 📚 Additional Resources

### Official Documentation
- **ALKiln Docs:** https://assemblyline.suffolklitlab.org/docs/components/ALKiln/
- **ALKiln GitHub:** https://github.com/SuffolkLITLab/ALKiln
- **Gherkin Reference:** https://cucumber.io/docs/gherkin/

### Your Repository
- **Workflow:** `.github/workflows/alkiln_tests.yml`
- **Tests:** `docassemble/alkilntests/data/sources/test_interviews.feature`
- **Actions:** https://github.com/jswizzle3737/docassemble-alkiln-tests/actions

### Community
- **Assembly Line Project:** https://suffolklitlab.org/
- **Docassemble Forum:** https://docassemble.org/docs/support.html
- **GitHub Issues:** https://github.com/SuffolkLITLab/ALKiln/issues

---

## ✅ Quick Reference Card

### Most Common Steps

```gherkin
# Start
Given I start the interview at "interview_name"

# Fill fields
And I set the var "variable_name" to "value"

# Navigate
And I continue

# Verify
Then I should see the phrase "expected text"

# Sign
And I sign

# Download
Then I download "filename.pdf"

# Screenshot
Then I take a screenshot
```

### Quick Test Template

```gherkin
Feature: [Form Name]

Scenario: [What you're testing]
  Given I start the interview at "[interview_name]"
  And I set the var "[field1]" to "[value1]"
  And I continue
  And I set the var "[field2]" to "[value2]"
  And I continue
  Then I should see the phrase "[expected result]"
```

---

## 🚀 Your ALKiln Setup

✅ **Already Configured:**
- GitHub Actions workflow
- ALKiln v5 integration
- Server connection
- API authentication
- Automatic test runs

✅ **Ready to Use:**
- All steps in this reference
- GitHub secrets integration
- Automated PDF testing
- Accessibility checks

**Next Steps:**
1. Write tests using patterns from this guide
2. Push to GitHub
3. Watch tests run automatically
4. Iterate and improve!

**You have the complete ALKiln framework at your fingertips!** 🎉
