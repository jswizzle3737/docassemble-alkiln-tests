# 🔍 Debugging GitHub Actions Startup Failure

## Current Issue

**Status:** `startup_failure` with **0 jobs executed**  
**Workflow Run:** https://github.com/jswizzle3737/docassemble-alkiln-tests/actions/runs/19052870660

This specific error pattern means the workflow is failing **before any jobs can start**, which almost always indicates a secrets configuration problem.

---

## 🎯 Most Likely Cause: Secrets Not Actually Configured

Even though you believe secrets are "up" (configured), the `startup_failure` with 0 jobs strongly suggests they are **not accessible** to the workflow.

### Step 1: Verify Secrets Exist

1. Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/settings/secrets/actions
2. Look for these TWO secrets in the "Repository secrets" section:
   - `SERVER_URL`
   - `DOCASSEMBLE_DEVELOPER_API_KEY`

**Expected:** You should see both secrets listed by name (values are hidden)

**If you DON'T see both secrets:**
- They were never created, or
- They were deleted, or
- They exist in a different location (organization secrets, environment secrets)

---

## 🔧 How to Fix

### If Secrets Are Missing

Click **"New repository secret"** and add:

**Secret 1:**
- Name: `SERVER_URL`  
- Value: `https://docassemble-uugcj-u59651.vm.elestio.app:443/`  
  (or your actual server URL)

**Secret 2:**
- Name: `DOCASSEMBLE_DEVELOPER_API_KEY`  
- Value: Your API key from the docassemble server

### If Secrets Exist But Still Failing

1. **Check the names are EXACTLY correct** (case-sensitive):
   - ✅ `SERVER_URL` (correct)
   - ❌ `server_url` (wrong - all lowercase)
   - ❌ `Server_Url` (wrong - wrong case)

2. **Check you added them to the right place:**
   - ✅ Repository secrets (Settings → Secrets and variables → Actions)
   - ❌ NOT in Environments (unless workflow specifies one)
   - ❌ NOT in Organization secrets (unless inherited)

3. **Verify the values are not empty:**
   - GitHub allows creating secrets with empty values
   - Make sure you actually pasted the values

---

## 🧪 Test Secrets Configuration

I've created a diagnostic workflow to help debug this. To run it:

1. Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions/workflows/test_secrets.yml
2. Click **"Run workflow"**
3. Select your branch
4. Click **"Run workflow"**

This will:
- ✅ Check if `SERVER_URL` is accessible
- ✅ Check if `DOCASSEMBLE_DEVELOPER_API_KEY` is accessible  
- ✅ Validate `SERVER_URL` format
- ❌ Show clear error if secrets are missing

---

## 📊 Understanding "startup_failure"

| Failure Type | Jobs Executed | Cause |
|--------------|---------------|-------|
| `startup_failure` | 0 | Workflow can't start (secrets, syntax, action issues) |
| `failure` | 1+ | Jobs ran but failed during execution |

Your case: **0 jobs** = the workflow never got to run the ALKiln action, indicating a configuration problem.

---

## 🔍 Alternative Causes (Less Likely)

### 1. ALKiln Action Issue

The action `SuffolkLITLab/ALKiln@v5` might be unavailable. Check:
- https://github.com/SuffolkLITLab/ALKiln/releases

If v5 doesn't exist, try changing to `@v4` or `@latest` in `.github/workflows/alkiln_tests.yml`

### 2. Pull Request from Fork

If this PR is from a forked repository:
- Secrets are NOT accessible to PRs from forks (security feature)
- Solution: Push directly to a branch in your repository, not from a fork

### 3. Required Checks

Check if there are branch protection rules requiring checks to pass:
- https://github.com/jswizzle3737/docassemble-alkiln-tests/settings/branches

---

## ✅ Success Indicators

Once secrets are working, you'll see:

1. **Status changes** from `startup_failure` to `in_progress` or `queued`
2. **Jobs count > 0** (at least 1 job will run)
3. **Job logs appear** showing ALKiln execution
4. If there are still errors, they'll be **in the job logs** (different from startup_failure)

---

## 🆘 Next Steps

1. **Verify secrets at:** https://github.com/jswizzle3737/docassemble-alkiln-tests/settings/secrets/actions
2. **Run diagnostic workflow** (see "Test Secrets Configuration" above)
3. **If secrets are there:** Delete and recreate them (might be a GitHub cache issue)
4. **If still failing:** Share screenshot of your secrets page (names only, not values)

---

## 📝 Quick Checklist

- [ ] Went to Settings → Secrets and variables → Actions
- [ ] Saw `SERVER_URL` listed
- [ ] Saw `DOCASSEMBLE_DEVELOPER_API_KEY` listed
- [ ] Names are EXACTLY as shown (case-sensitive)
- [ ] Values are not empty
- [ ] Secrets are in "Repository secrets" section
- [ ] Not using a forked repository

If all checked and still failing, run the diagnostic workflow for more info.
