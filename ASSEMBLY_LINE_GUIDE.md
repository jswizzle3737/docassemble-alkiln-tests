# Working with Document Assembly Line

## 🎯 What is Assembly Line?

The **Document Assembly Line** is a toolkit for converting paper court forms into guided, step-by-step web applications. It's already installed on your docassemble server!

### Installed Packages:
- ✅ **docassemble.AssemblyLine v4.2.0** - Core runtime code
- ✅ **docassemble.ALToolbox v0.13.1** - Additional utilities
- ✅ **docassemble.ALDashboard v0.25.0** - Dashboard features
- ✅ **docassemble.GithubFeedbackForm v0.5.6** - Feedback system

---

## 📝 Creating Assembly Line Forms

### Option 1: Using the Assembly Line Weaver (Recommended)

The **Weaver** is a tool that converts PDF forms into docassemble interviews automatically.

1. **Access the Weaver:**
   - URL: https://apps-dev.suffolklitlab.org/start/assemblylinewizard/assembly_line
   - Or search for "Assembly Line Weaver" online

2. **Upload your PDF form**

3. **Answer questions about the form:**
   - Form fields
   - Question order
   - Logic and branching

4. **Generate the interview:**
   - Downloads a complete docassemble package
   - Upload to your server via Package Management

### Option 2: Manual Coding with Assembly Line Classes

You can also write Assembly Line forms manually using the AL objects.

**Example: Basic Assembly Line Interview**

```yaml
---
include:
  - docassemble.AssemblyLine:assembly_line.yml
---
metadata:
  title: Simple Court Form
  short title: Court Form
---
mandatory: True
code: |
  # Interview order block
  users[0].name.first
  users[0].address.address
  signature_date
  download_form
---
objects:
  - users: ALPeopleList.using(ask_number=True)
---
question: |
  What is your name?
fields:
  - First name: users[0].name.first
  - Last name: users[0].name.last
---
question: |
  What is your address?
fields:
  - Street: users[0].address.address
  - City: users[0].address.city
  - State: users[0].address.state
  - Zip: users[0].address.zip
---
question: |
  Sign your name
signature: users[0].signature
under: |
  ${ users[0].name.full() }
---
code: |
  signature_date = today()
---
event: download_form
question: |
  Your form is ready
subquestion: |
  Thank you, ${ users[0].name.full() }.

  Your form has been completed.
buttons:
  - Download PDF: download
```

---

## 🧪 Testing Assembly Line Forms

### Finding Assembly Line Interviews

Assembly Line interviews are typically named with a pattern like:
- Form name (e.g., `complaint`, `motion`, `answer`)
- Jurisdiction prefix (e.g., `ma_` for Massachusetts)

**List available interviews:**
```bash
# Use API to check
curl -X GET "https://your-server:443/api/interviews" \
  -H "X-API-Key: your-key"
```

Or log into docassemble and check:
- **Playground** → See your custom forms
- **Available Interviews** → See all installed interviews

### Writing Tests for Assembly Line Forms

Assembly Line forms typically use standard object names:

**Common AL Variables:**
- `users[0].name.first` - User's first name
- `users[0].name.last` - User's last name
- `users[0].address.address` - Street address
- `users[0].birthdate` - Birth date
- `other_parties[0].name.full()` - Opposing party
- `trial_court` - Court selection
- `docket_number` - Case number

**Example Test:**

```gherkin
Feature: Assembly Line Court Form Tests

Scenario: User completes simple motion form
  Given I start the interview at "ma_simple_motion"
  # User information
  And I set the var "users[0].name.first" to "Jane"
  And I set the var "users[0].name.last" to "Smith"
  And I continue
  # Address
  And I set the var "users[0].address.address" to "123 Main St"
  And I set the var "users[0].address.city" to "Boston"
  And I set the var "users[0].address.state" to "MA"
  And I set the var "users[0].address.zip" to "02108"
  And I continue
  # Court selection
  And I set the var "trial_court" to "Boston Municipal Court"
  And I continue
  # Signature
  And I sign
  And I continue
  # Verify completion
  Then I should see the phrase "Your form is ready"
  And I should see the phrase "Jane Smith"
```

### Complex Assembly Line Tests

**Testing with Multiple Parties:**

```gherkin
Scenario: Motion with opposing party
  Given I start the interview at "ma_motion_continue"
  # Plaintiff (user)
  And I set the var "users[0].name.first" to "Jane"
  And I set the var "users[0].name.last" to "Smith"
  And I continue
  # Defendant (other party)
  And I set the var "other_parties[0].name.first" to "John"
  And I set the var "other_parties[0].name.last" to "Doe"
  And I continue
  # Case information
  And I set the var "docket_number" to "2023-CV-12345"
  And I continue
  # Motion details
  And I set the var "motion_reason" to "Need more time to prepare"
  And I continue
  Then I should see the phrase "Motion to Continue"
  And I should see the phrase "Jane Smith"
  And I should see the phrase "John Doe"
```

---

## 🔄 Assembly Line Development Workflow

### 1. Create or Generate Form

**Using Weaver:**
1. Go to Assembly Line Weaver
2. Upload PDF form
3. Configure fields and logic
4. Download package

**Manual Creation:**
1. Create YAML file in Playground
2. Include Assembly Line library
3. Use AL objects (ALPeopleList, ALDocument, etc.)
4. Test manually

### 2. Install on Docassemble Server

**If using Weaver output:**
1. In docassemble: **Package Management**
2. Upload the generated ZIP file
3. Restart if needed

**If coding in Playground:**
1. Save in Playground
2. Test immediately
3. Create package when ready

### 3. Write Automated Tests

1. **Identify interview filename**
   - Check Playground or Package Management
   - Note the full path (e.g., `docassemble.MAEvictionDefense:data/questions/answer.yml`)

2. **Write test scenarios** in `test_interviews.feature`

3. **Test locally first:**
   - Run interview manually
   - Note all variable names
   - Note exact text for assertions

4. **Push to GitHub** - tests run automatically!

### 4. Monitor and Iterate

1. **Check Actions tab** for test results
2. **Fix any failures**
3. **Update interview or tests** as needed
4. **Repeat**

---

## 📚 Assembly Line Object Reference

### ALPeopleList
Manages lists of people (users, opposing parties, etc.)

```yaml
objects:
  - users: ALPeopleList.using(ask_number=True)
  - other_parties: ALPeopleList.using(ask_number=True)
```

**Common attributes:**
- `users[0].name.first`
- `users[0].name.last`
- `users[0].name.full()` - Method
- `users[0].address.address`
- `users[0].address.city`
- `users[0].phone_number`
- `users[0].email`

### ALDocument
Manages PDF generation and assembly

```yaml
objects:
  - motion_to_continue: ALDocument.using(
      title="Motion to Continue",
      filename="motion_to_continue",
      enabled=True
    )
```

### Trial Court
Court selection with built-in lists

```yaml
question: |
  Which court is your case in?
fields:
  - no label: trial_court
    datatype: object
    choices: all_courts
```

---

## 🎯 Example: Complete Assembly Line Form + Test

### Assembly Line Interview

**File:** `docassemble/alkilntests/data/questions/simple_complaint.yml`

```yaml
---
include:
  - docassemble.AssemblyLine:assembly_line.yml
---
metadata:
  title: Simple Complaint Form
  short title: Complaint
---
mandatory: True
code: |
  # Interview order
  intro_screen
  users[0].name.first
  users[0].address.address
  other_parties[0].name.first
  claim_description
  signature_date
  download_screen
---
objects:
  - users: ALPeopleList.using(ask_number=True, target_number=1)
  - other_parties: ALPeopleList.using(ask_number=True, target_number=1)
---
question: |
  File a Complaint
subquestion: |
  This interview will help you file a complaint in court.
continue button field: intro_screen
---
question: |
  What is your name?
fields:
  - First name: users[0].name.first
  - Last name: users[0].name.last
---
question: |
  What is your address?
fields:
  - Street: users[0].address.address
  - City: users[0].address.city
  - State: users[0].address.state
    code: |
      states_list()
  - Zip: users[0].address.zip
---
question: |
  Who are you filing against?
fields:
  - First name: other_parties[0].name.first
  - Last name: other_parties[0].name.last
---
question: |
  Describe your claim
fields:
  - Tell us what happened: claim_description
    datatype: area
---
question: |
  Sign your name
signature: users[0].signature
under: |
  ${ users[0].name.full() }
---
code: |
  signature_date = today()
---
event: download_screen
question: |
  Your complaint is ready
subquestion: |
  Thank you, ${ users[0].name.full() }.

  You are filing a complaint against ${ other_parties[0].name.full() }.
buttons:
  - Download: download
  - Restart: restart
```

### Corresponding Test

**File:** `test_interviews.feature`

```gherkin
Feature: Simple Complaint Form

Scenario: User files a complete complaint
  Given I start the interview at "simple_complaint"
  # Intro screen
  And I continue
  # Plaintiff name
  And I set the var "users[0].name.first" to "Jane"
  And I set the var "users[0].name.last" to "Smith"
  And I continue
  # Plaintiff address
  And I set the var "users[0].address.address" to "123 Main Street"
  And I set the var "users[0].address.city" to "Springfield"
  And I set the var "users[0].address.state" to "MA"
  And I set the var "users[0].address.zip" to "01101"
  And I continue
  # Defendant name
  And I set the var "other_parties[0].name.first" to "John"
  And I set the var "other_parties[0].name.last" to "Doe"
  And I continue
  # Claim description
  And I set the var "claim_description" to "The defendant owes me $5000"
  And I continue
  # Signature
  And I sign
  And I continue
  # Verify results
  Then I should see the phrase "Your complaint is ready"
  And I should see the phrase "Jane Smith"
  And I should see the phrase "John Doe"

Scenario: Form requires all mandatory fields
  Given I start the interview at "simple_complaint"
  And I continue
  # Try to skip required fields
  And I continue
  # Should see validation error
  Then I should see the phrase "This field is required"
```

---

## 📖 Additional Resources

### Official Documentation
- **Assembly Line Docs:** https://suffolklitlab.org/docassemble-AssemblyLine-documentation/
- **GitHub Repository:** https://github.com/SuffolkLITLab/docassemble-AssemblyLine
- **ALKiln Testing Guide:** https://assemblyline.suffolklitlab.org/docs/alkiln/

### Tools
- **Assembly Line Weaver:** https://apps-dev.suffolklitlab.org/start/assemblylinewizard/assembly_line
- **Form Explorer:** Check what forms are available in your jurisdiction

### Community
- **Suffolk LIT Lab:** https://suffolklitlab.org/
- **Docassemble Slack:** Join for help and discussion
- **GitHub Issues:** Report bugs or request features

---

## 🆘 Common Issues

### "Interview not found"
- Check the full interview path: `docassemble.PackageName:data/questions/file.yml`
- Verify package is installed: Check Package Management
- For playground files, use: `docassemble.playground1:filename.yml`

### "Variable not defined"
- Assembly Line uses specific object structures
- Check the AL documentation for correct variable names
- Test manually first to see variable names in the interview

### "Signature not working in tests"
- Use: `And I sign` step in ALKiln tests
- Signature fields have special handling in Assembly Line

### "Multi-page forms timing out"
- Add wait steps: `And I wait 2 seconds`
- Break into smaller test scenarios
- Check for JavaScript-heavy pages

---

## 🚀 Quick Start Checklist

- ✅ Assembly Line installed (v4.2.0)
- ✅ docassemble server accessible
- ✅ GitHub Actions configured
- ✅ API key working

**Next Steps:**

1. **Create or find an Assembly Line form**
   - Use Weaver to generate from PDF
   - Or code manually in Playground

2. **Test manually first**
   - Run in docassemble
   - Note variable names
   - Note workflow

3. **Write automated test**
   - Add to `test_interviews.feature`
   - Use AL variable patterns

4. **Push and verify**
   - Commit to GitHub
   - Check Actions tab
   - Fix any failures

**You're ready to build Assembly Line forms!** 🎉
