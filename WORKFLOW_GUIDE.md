# Docassemble + ALKiln Testing Workflow Guide

## 🌐 Accessing Your Docassemble Server

### Server URL
```
https://docassemble-uugcj-u59651.vm.elestio.app:443/
```

### Login Credentials
- Email: `j.mckenzie.stevens@gmail.com`
- Password: [Your docassemble password]

---

## 📝 Working with Docassemble Interviews

### 1. Access the Playground (Development Area)

1. **Log into docassemble** (link above)
2. **Click your name** (top right) → **Playground**
3. This is where you create and edit interview files

### 2. Create a New Interview

**In the Playground:**
1. Click **"Add"** button
2. Select **"Interview"**
3. Choose a filename (e.g., `my_interview.yml`)
4. Write your interview YAML code

**Example Simple Interview:**
```yaml
---
metadata:
  title: My First Interview
  short title: First
---
mandatory: True
question: |
  What is your name?
fields:
  - Name: user_name
---
mandatory: True
question: |
  Hello, ${ user_name }!
subquestion: |
  Thank you for using this interview.
buttons:
  - Exit: exit
```

### 3. Save and Test Manually

1. Click **"Save"** in the Playground
2. Click **"Run"** to test your interview in the browser
3. Make sure it works before writing automated tests

---

## 🧪 Writing Tests for Your Interviews

### Where Tests Go

Tests go in: `docassemble/alkilntests/data/sources/test_interviews.feature`

### Basic Test Structure

```gherkin
Feature: My Interview Tests

Scenario: User completes name interview
  Given I start the interview at "my_interview"
  And I set the var "user_name" to "John Doe"
  And I continue
  Then I should see the phrase "Hello, John Doe"
  And I should see the phrase "Thank you for using this interview"
```

### Important Notes:

1. **Interview filename**: Use just the name, no `.yml` extension
   - ✅ `"my_interview"`
   - ❌ `"my_interview.yml"`

2. **Variable names**: Must match exactly from your YAML
   ```yaml
   # In interview:
   fields:
     - Name: user_name

   # In test:
   And I set the var "user_name" to "John Doe"
   ```

3. **Phrase matching**: Must be exact text from your interview
   ```yaml
   # In interview:
   question: |
     Thank you for using this interview.

   # In test:
   Then I should see the phrase "Thank you for using this interview"
   ```

---

## 🔄 The Complete Workflow

### Step 1: Create Interview in Playground
```
1. Log into docassemble
2. Go to Playground
3. Create/edit interview YAML file
4. Save it
5. Test it manually (click "Run")
```

### Step 2: Install Package (If Needed)

If you want your interview accessible by ALKiln tests:

**Option A: Use Playground Directly**
- ALKiln can test playground interviews using format: `"docassemble.playground1:my_interview.yml"`

**Option B: Install This Package**
1. In docassemble, go to **Package Management**
2. Install from GitHub: `https://github.com/jswizzle3737/docassemble-alkiln-tests.git`
3. Your interviews in `docassemble/alkilntests/data/questions/` will be available

### Step 3: Write Tests

1. **Edit locally:** `docassemble/alkilntests/data/sources/test_interviews.feature`
2. **Or edit the root:** `test_interviews.feature` (they should match)
3. Write Gherkin test scenarios

### Step 4: Push to GitHub

```bash
git add .
git commit -m "Add new interview tests"
git push
```

### Step 5: Watch Tests Run

1. Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions
2. Click the latest workflow run
3. See results in real-time

---

## 📚 Common ALKiln Test Steps

### Navigation
```gherkin
Given I start the interview at "interview_name"
And I continue
And I wait 2 seconds
```

### Setting Variables
```gherkin
# Text
And I set the var "user_name" to "John Doe"

# Boolean
And I set the var "is_eligible" to "True"

# Numbers (as strings)
And I set the var "age" to "25"
```

### Clicking Buttons
```gherkin
And I click the button for "button_variable_name"
```

### Assertions
```gherkin
Then I should see the phrase "Expected text"
And I should not see the phrase "Unexpected text"
```

---

## 🎯 Example: Complete Workflow

### 1. Create Interview in Docassemble Playground

**File: `intake_form.yml`**
```yaml
---
metadata:
  title: Client Intake Form
---
mandatory: True
question: |
  Client Information
fields:
  - First Name: client_first_name
  - Last Name: client_last_name
  - Phone: client_phone
---
mandatory: True
question: |
  Thank you, ${ client_first_name } ${ client_last_name }!
subquestion: |
  We have received your information.

  We will contact you at ${ client_phone }.
buttons:
  - Restart: restart
```

### 2. Write Test in Repository

**Edit: `test_interviews.feature`**
```gherkin
Feature: Intake Form Tests

Scenario: User submits intake form
  Given I start the interview at "docassemble.playground1:intake_form.yml"
  And I set the var "client_first_name" to "Jane"
  And I set the var "client_last_name" to "Smith"
  And I set the var "client_phone" to "555-1234"
  And I continue
  Then I should see the phrase "Thank you, Jane Smith"
  And I should see the phrase "We will contact you at 555-1234"

Scenario: Form validation works
  Given I start the interview at "docassemble.playground1:intake_form.yml"
  And I continue
  Then I should see the phrase "This field is required"
```

### 3. Commit and Push

```bash
git add test_interviews.feature
git commit -m "Add intake form tests"
git push
```

### 4. Tests Run Automatically!

GitHub Actions will:
1. Connect to your docassemble server
2. Start the interview
3. Fill in the fields
4. Check for expected text
5. Report pass/fail

---

## 🔧 Tips & Tricks

### Development Cycle

1. **Write interview** in docassemble Playground
2. **Test manually** (click "Run" in Playground)
3. **Write automated test** in this repository
4. **Push and verify** tests pass
5. **Iterate** - fix issues, update tests

### Testing Playground Interviews

Use the full path format:
```gherkin
Given I start the interview at "docassemble.playground1:my_interview.yml"
```

### Testing Installed Package Interviews

If you install this package in docassemble:
```gherkin
Given I start the interview at "test"
# This refers to docassemble/alkilntests/data/questions/test.yml
```

### Debugging Failed Tests

1. **Check Actions logs:** See exact error message
2. **Test manually:** Run interview in browser
3. **Check variable names:** Must match YAML exactly
4. **Check phrases:** Must match text exactly (case-sensitive)

---

## 📖 Additional Resources

- **ALKiln Documentation:** https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/
- **Docassemble Docs:** https://docassemble.org/docs.html
- **YAML Syntax:** https://docassemble.org/docs/interview.html
- **Gherkin Syntax:** https://cucumber.io/docs/gherkin/

---

## 🆘 Quick Help

**"My test can't find the interview"**
- Use full path: `docassemble.playground1:filename.yml`
- Or install the package in docassemble

**"Variables aren't being set"**
- Check spelling matches YAML exactly
- All values must be strings (in quotes)

**"Test fails but interview works manually"**
- Check for timing issues (add `And I wait 2 seconds`)
- Verify exact text matching in assertions

**"Need help?"**
- Check GitHub Actions logs for detailed errors
- Test the interview manually first
- Review TROUBLESHOOTING.md in this repository
