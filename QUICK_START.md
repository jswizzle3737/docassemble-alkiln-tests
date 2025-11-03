# 🚀 Quick Start: Begin Testing in GitHub (5 Minutes)

New to ALKiln testing? Follow these 3 simple steps to start testing your docassemble interviews directly in GitHub.

---

## Step 1: Add Your Credentials (2 minutes)

Click this link to go directly to your repository secrets:

**👉 [Open Secrets Settings](https://github.com/jswizzle3737/docassemble-alkiln-tests/settings/secrets/actions)**

Then add these two secrets:

### Secret #1
- Click **"New repository secret"**
- **Name:** `SERVER_URL`
- **Secret:** `https://docassemble-uugcj-u59651.vm.elestio.app:443/`
- Click **"Add secret"**

### Secret #2
- Click **"New repository secret"** again
- **Name:** `DOCASSEMBLE_DEVELOPER_API_KEY`
- **Secret:** `1gcxf6lPnmwGVlqe2OHIPp2yAkCt25uy`
- Click **"Add secret"**

✅ **Done!** Your credentials are now securely stored.

---

## Step 2: Edit Your Test File (2 minutes)

Click this link to edit your test file directly in GitHub:

**👉 [Edit test_interviews.feature](https://github.com/jswizzle3737/docassemble-alkiln-tests/edit/main/test_interviews.feature)**

Replace the example interview name `"test"` with your actual interview filename (without the `.yml` extension).

For example, if your interview is called `intake_form.yml`, change line 8 to:
```gherkin
  Given I start the interview at "intake_form"
```

Then:
- Scroll to the bottom
- Click **"Commit changes..."**
- Click **"Commit changes"** in the dialog

✅ **Done!** Your test is now configured.

---

## Step 3: Watch Your Tests Run (1 minute)

Your test will run automatically! Click this link to see the results:

**👉 [View Test Results](https://github.com/jswizzle3737/docassemble-alkiln-tests/actions)**

You should see a new workflow run starting. Click on it to watch the test execute in real-time.

- ✅ **Green checkmark** = Test passed! 🎉
- ❌ **Red X** = Test failed (see logs for details)

✅ **Done!** You're now testing your docassemble interviews automatically!

---

## 🎯 What Happens Now?

Every time you:
- **Push code** to the main branch → Tests run automatically
- **Create a pull request** → Tests run automatically
- **Edit your test file** → Tests run automatically

Your interviews are now continuously tested! 🚀

---

## 📚 Next Steps

Once your first test is working, you can:

1. **Add more test scenarios** - Edit `test_interviews.feature` to add more tests
2. **Learn advanced testing** - See [GETTING_STARTED.md](./GETTING_STARTED.md) for detailed examples
3. **Troubleshoot issues** - See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) if something goes wrong
4. **Read full docs** - See [README.md](./README.md) for complete documentation

---

## 🆘 Something Not Working?

### Tests show "startup_failure"?
- Double-check your secrets are copied **exactly** as shown above
- Make sure `SERVER_URL` ends with `:443/`

### Interview not found?
- Use just the filename, like `"intake_form"` not `"intake_form.yml"`
- Make sure the interview exists on your docassemble server

### More help?
- See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
- Check the [Actions logs](https://github.com/jswizzle3737/docassemble-alkiln-tests/actions) for error details

---

**That's it! You're ready to start testing! 🎉**
