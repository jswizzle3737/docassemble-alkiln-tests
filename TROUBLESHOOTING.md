# Troubleshooting Guide

## 🔴 Tests Show "startup_failure"

**What this means:** ALKiln couldn't connect to your docassemble server.

### Fix Checklist:

1. **Verify SERVER_URL Secret**
   - Go to: Settings → Secrets and variables → Actions
   - Check `SERVER_URL` value is correct for your server
   - ⚠️ Must include port (`:443` for HTTPS, or appropriate port)
   - ⚠️ Must end with `/` (trailing slash)
   - Example: `https://your-server.com:443/`
   - If wrong, delete and recreate it

2. **Verify API Key Secret**
   - Go to: Settings → Secrets and variables → Actions
   - Check `DOCASSEMBLE_DEVELOPER_API_KEY` matches your server's API key
   - Get the correct key from: User menu → API keys on your docassemble server
   - If wrong, delete and recreate it

3. **Check Server is Running**
   - Visit your docassemble server URL in your browser
   - Should see docassemble login page
   - If not, server is down or unreachable

4. **Check API Key is Active**
   - Log into your docassemble server
   - Go to: User menu → API keys
   - Make sure your API key shows as active
   - If expired or deleted, create a new one

### Still failing? Try this:
```bash
# Copy secrets exactly as they should be
# Then delete the old ones and recreate them
```

---

## ❌ Interview File Not Found

**Error message includes:** "interview not found" or similar

### Fix:

1. **Use filename only, no extension:**
   ```gherkin
   ✅ CORRECT: Given I start the interview at "intake_form"
   ❌ WRONG: Given I start the interview at "intake_form.yml"
   ```

2. **Double-check file exists:**
   - Log into your docassemble server
   - Go to: Tools → Interviews
   - Make sure your interview is listed there

3. **Check interview is enabled:**
   - Some interviews need to be published/enabled
   - Ask your docassemble administrator if unsure

---

## 🔧 Variable Not Being Set

**Test runs but variables don't seem to change**

### Check these:

1. **Variable name spelling:**
   ```gherkin
   # In test (must match YAML exactly):
   And I set the var "client_name" to "John"
   
   # In your interview YAML:
   - Client name: client_name
   ```
   Variable names are case-sensitive!

2. **Data types for special values:**
   ```gherkin
   ✅ CORRECT: And I set the var "is_eligible" to "True"
   ❌ WRONG: And I set the var "is_eligible" to "true"
   
   ✅ CORRECT: And I set the var "age" to "25"
   ❌ WRONG: And I set the var "age" to 25
   ```
   All values must be strings (quoted)

3. **Variable actually exists in interview:**
   - Open your interview YAML file
   - Search for `client_name:` (or whatever variable)
   - Make sure it's spelled exactly the same

---

## 📝 Phrase Not Found / Assertion Fails

**Error: "Expected to see phrase 'X' but didn't"**

### Debug this:

1. **Temporarily add debugging line:**
   ```gherkin
   Scenario: Debug test
     Given I start the interview at "intake_form"
     # This will show actual page content when it fails:
     Then I should see the phrase "THIS_WONT_BE_FOUND"
   ```
   The error message will show what was actually on the page.

2. **Check exact text matching:**
   ```gherkin
   ✅ CORRECT: Then I should see the phrase "Thank you for submitting"
   ❌ WRONG: Then I should see the phrase "Thank you"
   ```
   Must match the complete phrase in your interview.

3. **Account for whitespace/formatting:**
   - Copy/paste text directly from your interview file
   - Watch out for extra spaces or special characters

---

## ⏰ Tests Timing Out / Taking Too Long

**Workflow takes too long or times out**

### Fix:

1. **Add timeout configuration** (optional, advanced):
   Edit `.github/workflows/alkiln_tests.yml`:
   ```yaml
   env:
     MAX_SECONDS_FOR_SETUP: "300"     # Increase if needed
     DOCASSEMBLE_TIMEOUT: "120"       # Increase if needed
   ```

2. **Simplify your tests:**
   - Break complex tests into smaller scenarios
   - Each scenario should test one thing
   - Reduces time for debugging when something fails

---

## 🔒 Secret Not Recognized / Access Denied

**Error about API key or permissions**

### Fix:

1. **Verify secret exists in GitHub:**
   - Go to: Settings → Secrets and variables → Actions
   - Both `SERVER_URL` and `DOCASSEMBLE_DEVELOPER_API_KEY` should be listed
   - If missing, they weren't saved

2. **Check GitHub secret scope:**
   - Secrets only work for actions in this repository
   - If you're using a public repository, be extra careful with credentials

3. **Try regenerating:**
   - Delete the secret
   - Copy the value fresh
   - Recreate it
   - Run test again

---

## 💾 No Test Results / Can't See Output

**Tests run but no output or results visible**

### Check this:

1. **Go to Actions tab:**
   - https://github.com/jswizzle3737/docassemble-alkiln-tests/actions
   - Click the latest workflow run
   - Click "Run ALKiln Tests" step
   - Scroll through logs

2. **Watch test output:**
   - Each step in the test shows in the logs
   - Look for which step failed
   - Error message tells you what went wrong

---

## 🎯 None of These Help?

**Try these debugging steps:**

1. **Run a minimal test:**
   ```gherkin
   Scenario: Minimal test
     Given I start the interview at "test"
   ```
   Just start, don't continue or assert anything.
   If this passes, problem is with your test logic.
   If this fails, problem is server connection.

2. **Check GitHub Actions logs:**
   - Full verbose output is in Actions tab
   - Copy the full error message
   - Paste into error decoder or search online

3. **Verify your interview works manually:**
   - Log into docassemble server
   - Load your interview manually
   - Make sure it actually works before testing it

4. **Re-add secrets:**
   - Delete both secrets
   - Add them again very carefully
   - Copy/paste exact values to avoid typos

---

## 📞 Still Stuck?

- [ALKiln GitHub Issues](https://github.com/SuffolkLITLab/ALKiln/issues) - Report bugs
- [ALKiln Docs](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/) - Full reference
- [Docassemble Community](https://docassemble.org/docs/support.html) - General help
- Check your docassemble server logs for detailed error messages
