# 🧪 docassemble-alkiln-tests

Automated testing environment for docassemble interviews using [ALKiln](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/).

## 🚀 New Here? Start in 5 Minutes!

**👉 [Follow the QUICK_START.md Guide](./QUICK_START.md)** - The simplest way to begin testing in GitHub!

---

## ⚡ Quick Start (2 minutes)

### 1️⃣ Add GitHub Secrets
1. Go to your repo → **Settings** → **Secrets and variables** → **Actions**
2. Click **"New repository secret"** and add these two:

| Secret Name | Value |
|---|---|
| `SERVER_URL` | `https://docassemble-uugcj-u59651.vm.elestio.app:443/` |
| `DOCASSEMBLE_DEVELOPER_API_KEY` | `1gcxf6lPnmwGVlqe2OHIPp2yAkCt25uy` |

### 2️⃣ Create Your Test File
Create `test_interviews.feature`:
```gherkin
Feature: Your Interview Tests

Scenario: User completes interview
  Given I start the interview at "your_interview_file"
  And I set the var "client_name" to "John Doe"
  And I continue
  Then I should see the phrase "Thank you"
```

### 3️⃣ Run Tests
- **Push to main** → Tests run automatically ✅
- **Create a PR** → Tests run automatically ✅
- Check results in **Actions** tab

---

## 📁 Project Structure

```
.
├── .github/workflows/
│   └── alkiln_tests.yml          ← GitHub Actions workflow (auto-triggered)
├── docassemble/
│   └── alkilntests/
│       └── data/
│           ├── questions/         ← Your interview YAML files here
│           ├── templates/         ← Document templates (optional)
│           └── static/            ← CSS/JS/images (optional)
├── test_interviews.feature        ← Your Gherkin test scenarios
├── setup.py                        ← Package configuration
└── README.md                       ← This file
```

---

## 🧪 Writing Tests

### Simple Tests
```gherkin
Scenario: Simple form submission
  Given I start the interview at "intake_form"
  And I continue
  Then I should see the phrase "Application received"
```

### Complex Tests
```gherkin
Scenario: Multi-step interview validation
  Given I start the interview at "divorce_papers"
  And I set the var "attorney_licensed" to "True"
  And I set the var "client_state" to "Massachusetts"
  And I continue
  And I click the button for "spouse_name"
  And I set the var "spouse_name" to "Jane Smith"
  And I continue
  Then I should see the phrase "Spouse information confirmed"
```

### Common Steps
- `Given I start the interview at "filename"` - Load an interview
- `And I set the var "variable" to "value"` - Fill a field
- `And I continue` - Click continue/next
- `Then I should see the phrase "text"` - Assert text appears
- `And I click the button for "variable"` - Click a specific button

📚 [Full ALKiln Step Documentation](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/)

---

## 🚀 Advanced Options

### Add Environment Variables
Edit `.github/workflows/alkiln_tests.yml`:
```yaml
env:
  MAX_SECONDS_FOR_SETUP: "300"
  DOCASSEMBLE_TIMEOUT: "120"
```

### Run Tests Locally (Advanced)
```bash
# Install docassemble (requires Docker and specific setup)
docker run -p 80:80 -p 443:443 jhpyle/docassemble
```

---

## ⚠️ Security Reminders

✅ **DO:**
- Use a **test server only** (never production)
- Create a **dedicated test account** on your docassemble instance
- Use **GitHub secrets** for all credentials
- Review [ALKiln security docs](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/)

❌ **DON'T:**
- Commit credentials to git
- Use production credentials
- Share API keys in issues/PRs

---

## 📖 Helpful Links

- [ALKiln Documentation](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/) - Complete test reference
- [Docassemble YAML Syntax](https://docassemble.org/docs/interview.html) - Interview file syntax
- [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) - How GitHub secrets work
- [Gherkin/Cucumber Syntax](https://cucumber.io/docs/gherkin/) - Test syntax reference

---

## 🆘 Troubleshooting

**Tests fail with "startup_failure"?**
- ✅ Verify `SERVER_URL` includes `:443/` (with port and trailing slash)
- ✅ Verify `DOCASSEMBLE_DEVELOPER_API_KEY` is correct and active
- ✅ Check that the test server is running and accessible

**Interview file not found?**
- ✅ Use the interview filename without `.yml` extension
- ✅ Make sure the interview exists on your docassemble server

**Variable not being set?**
- ✅ Use the exact variable name from your interview YAML
- ✅ Check data type (use `"True"` not `True` for booleans)

---

## 📞 Support

- [ALKiln GitHub Issues](https://github.com/SuffolkLITLab/ALKiln/issues)
- [Docassemble Community](https://docassemble.org/docs/support.html)
- [Assembly Line Slack](https://assemblyline.suffolklitlab.org/)
