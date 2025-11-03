# 🔧 Fixing GitHub Actions: Tests Not Running

## Problem

The GitHub Actions workflow shows **"startup_failure"** with **0 jobs executed**. This means the ALKiln tests are failing before they even start.

## Root Cause

The workflow requires two **GitHub repository secrets** that are either:
1. Not configured at all
2. Configured incorrectly
3. Using invalid/expired credentials

## Solution: Configure GitHub Secrets

### Step 1: Go to Repository Secrets

Open this URL in your browser:
```
https://github.com/jswizzle3737/docassemble-alkiln-tests/settings/secrets/actions
```

Or navigate manually:
1. Go to your repository
2. Click **Settings** tab
3. Click **Secrets and variables** → **Actions** (left sidebar)

### Step 2: Add Required Secrets

You need to add TWO secrets:

#### Secret #1: SERVER_URL

Click **"New repository secret"**
- **Name:** `SERVER_URL`
- **Secret:** Your docassemble testing server URL
  - Example format: `https://your-server.example.com:443/`
  - ⚠️ Must include `:443` (the port number)
  - ⚠️ Must end with `/` (trailing slash)

#### Secret #2: DOCASSEMBLE_DEVELOPER_API_KEY

Click **"New repository secret"** again
- **Name:** `DOCASSEMBLE_DEVELOPER_API_KEY`
- **Secret:** Your API key from the docassemble server
  - You can find this in your docassemble server:
    1. Log into your docassemble server
    2. Click your username → **Profile** or **API keys**
    3. Generate or copy an existing API key

## Verify the Fix

After adding both secrets:

1. Make any commit and push to the `main` branch (or your current PR branch)
2. Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions
3. Watch the workflow run
4. It should now show **jobs executing** instead of "startup_failure"

## What the Secrets Are Used For

- **SERVER_URL**: The ALKiln framework connects to this docassemble server to run your interviews
- **DOCASSEMBLE_DEVELOPER_API_KEY**: Authenticates with the server to install the interview package and run tests

## Testing Server Requirements

⚠️ **IMPORTANT**: Use a **dedicated testing server**, NEVER production!

The server must:
- Be running docassemble
- Be accessible from GitHub Actions (public URL or proper networking)
- Have the API key configured and active
- Have enough resources to handle test runs

## Alternative: Skip GitHub Actions and Run Locally

If you can't configure GitHub secrets or don't have a testing server, you can:

1. **Run local verification only:**
   ```bash
   ./verify_setup.sh
   ```

2. **Run the demonstration script:**
   ```bash
   ./run_demo.sh
   ```

3. **Validate the Python package:**
   ```bash
   python3 setup.py --version
   python3 -c "from docassemble.alkilntests import __version__; print(__version__)"
   ```

These local methods verify your code structure without needing the docassemble server.

## Common Errors and Fixes

### Error: "startup_failure" (current issue)
- **Cause**: Missing or incorrectly configured secrets
- **Fix**: Follow Step 1 and 2 above to add secrets

### Error: "Can't connect to server"
- **Cause**: Wrong SERVER_URL or server is down
- **Fix**: 
  - Verify SERVER_URL format (must include `:443/`)
  - Test server access by opening the URL in a browser
  - Check if server is running

### Error: "Authentication failed"
- **Cause**: Invalid or expired API key
- **Fix**:
  - Generate a new API key from your docassemble server
  - Update the secret in GitHub

### Error: "Interview not found"
- **Cause**: Interview file doesn't exist on the server
- **Fix**:
  - Make sure the interview is uploaded to your docassemble server
  - Check the interview filename in `test_interviews.feature` matches exactly

## Need Help?

- See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) for more details
- Check [ALKiln Documentation](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/)
- Review the [QUICK_START.md](./QUICK_START.md) guide

---

**Status**: Once secrets are configured, the tests will run automatically on every push and PR.
