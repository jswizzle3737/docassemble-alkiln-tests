# Getting Started with ALKiln Testing

New to this project? Follow these steps to get your first test running in 5 minutes.

## Step 1: Set Up GitHub Secrets (2 min)

First, get your API key from your docassemble testing server:

1. **Get Your API Key:**
   - Log into your docassemble testing server
   - Go to: User menu → API keys
   - Create a new API key or copy an existing test key

2. **Add Secrets to GitHub:**
   - Go to your repo: Settings → Secrets and variables → Actions
   - Click "New repository secret"

3. **Add First Secret:**
   - Name: `SERVER_URL`
   - Value: Your docassemble testing server URL with port and trailing slash
   - Format: `https://your-server.com:443/`
   - Click "Add secret"

4. **Add Second Secret:**
   - Name: `DOCASSEMBLE_DEVELOPER_API_KEY`
   - Value: The API key from step 1
   - Click "Add secret"

✅ **Done!** Both secrets are now saved.

---

## Step 2: Create Your Test File (2 min)

You need a file called `test_interviews.feature` in the root directory.

**Option A: Use VS Code**
1. Create new file: `Ctrl+N` (or `Cmd+N` on Mac)
2. Copy the test below
3. Save as `test_interviews.feature` in the root directory

**Option B: Use Command Line**
```bash
cat > test_interviews.feature << 'EOF'
Feature: Test my interviews

Scenario: Interview loads successfully
  Given I start the interview at "test"
  And I continue
  Then I should see the phrase "Thank you"
EOF
```

**Test Content:**
```gherkin
Feature: Test my interviews

Scenario: Interview loads successfully
  Given I start the interview at "test"
  And I continue
  Then I should see the phrase "Thank you"
```

⚠️ **Replace `"test"` with your actual interview filename** (without the `.yml` extension)

---

## Step 3: Trigger Your First Test (1 min)

Tests run automatically when you push to the repo.

**Quick way:**
```bash
git add test_interviews.feature
git commit -m "Add initial tests"
git push origin main
```

**Or in VS Code:**
1. Click Source Control (left sidebar)
2. Stage your changes
3. Type message: "Add initial tests"
4. Click Commit and Sync

---

## Step 4: Watch Your Tests Run (30 sec)

1. Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions
2. Click the latest workflow run
3. Watch it execute ✅

---

## 📝 Next: Write Better Tests

Once your first test passes, explore the `test_examples/` directory for ready-to-use patterns organized by category:

### 📁 Browse Test Pattern Examples

```
test_examples/
├── basic_tests.feature              # Simple forms, smoke tests
├── conditional_logic_tests.feature  # If/then branches, eligibility checks
├── multi_page_tests.feature         # Multi-step interview flows
├── button_navigation_tests.feature  # Button clicks, dynamic forms
├── validation_tests.feature         # Required fields, error handling
└── README.md                        # Complete usage guide
```

See `test_examples/README.md` for how to use these patterns.

### Quick Examples from the Collection

#### Fill Out a Form (from basic_tests.feature)
```gherkin
Scenario: User fills out intake form
  Given I start the interview at "intake_form"
  And I set the var "client_name" to "John Doe"
  And I set the var "client_email" to "john@example.com"
  And I continue
  Then I should see the phrase "Form submitted successfully"
```

### Test Multiple Pages
```gherkin
Scenario: Multi-page interview
  Given I start the interview at "divorce_papers"
  And I continue
  Then I should see the phrase "Spouse information"
  And I set the var "spouse_name" to "Jane Smith"
  And I continue
  Then I should see the phrase "Property division"
```

### Handle Buttons and Navigation
```gherkin
Scenario: Test navigation
  Given I start the interview at "quiz"
  And I continue
  Then I should see the phrase "Question 1"
  And I click the button for "answer_a"
  And I continue
  Then I should see the phrase "Correct!"
```

---

## 🐛 Something Not Working?

**Tests show "startup_failure"**
- Check your secrets are spelled exactly right (copy/paste them again)
- Make sure SERVER_URL ends with `:443/` (includes port and trailing slash)

**Interview file not found**
- Use just the filename (e.g., `"intake_form"` not `"intake_form.yml"`)
- Make sure the interview file actually exists on your docassemble server

**Variables not being set**
- Double-check variable names match your YAML file exactly
- For booleans use `"True"` or `"False"` (as strings)

---

## 📚 Learn More

- [Complete ALKiln Documentation](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/)
- [Docassemble Interview YAML Format](https://docassemble.org/docs/interview.html)
- [Gherkin Syntax (Test Writing Format)](https://cucumber.io/docs/gherkin/)

---

## ✅ Success Checklist

- [ ] Added both GitHub secrets
- [ ] Created `test_interviews.feature` file
- [ ] Updated interview filename in the test
- [ ] Pushed changes to main branch
- [ ] Saw green checkmark in Actions tab
- [ ] Ready to write more complex tests!

---

**Next Steps:**
1. Check your Actions tab to see test results
2. Add more test scenarios to `test_interviews.feature`
3. Integrate tests into your development workflow

🎉 **You're all set! Happy testing!**
