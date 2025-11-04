# 🚀 Deployment Checklist

Complete these steps to activate your Suffolk LIT Lab Assembly Line workflow.

---

## ✅ **Pre-Deployment Status**

**Current Status:**
- ✅ 3 commits ready to push
- ✅ All files created and configured
- ✅ VS Code configuration complete
- ✅ Documentation complete
- ⏳ Waiting for push to GitHub
- ⏳ Waiting for PROJECT_NAME secret

---

## 📋 **Step-by-Step Checklist**

### ☐ **Step 1: Add PROJECT_NAME Secret** (2 minutes)

**IMPORTANT:** Do this BEFORE pushing!

1. Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/settings/secrets/actions

2. Click **"New repository secret"**

3. Enter:
   ```
   Name: PROJECT_NAME
   Value: alkilntests
   ```

4. Click **"Add secret"**

**Why this is important:** The playground deployment workflow needs this to know which project to deploy to.

---

### ☐ **Step 2: Push to GitHub** (1 minute)

You have **3 commits** ready to push:

```
1. fa2d45a - security: Remove hardcoded credentials from documentation
2. c1148da - feat: Add complete Suffolk LIT Lab Assembly Line workflow
3. 4da65cd - feat: Add example Assembly Line motion interview with tests
```

**Push using:**

#### Option A: From Your Local Machine (Recommended)

If you have the repository on your computer:

```bash
cd /path/to/docassemble-alkiln-tests
git pull origin main
git push
```

#### Option B: From This Server

If you can set up GitHub authentication here:

```bash
# Set up git credentials
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Push (will prompt for GitHub username and personal access token)
git push
```

To get a personal access token:
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Select `repo` and `workflow` scopes
4. Copy the token
5. Use as password when pushing

---

### ☐ **Step 3: Watch Workflows Run** (5-10 minutes)

After pushing, go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions

You'll see **multiple workflows** start automatically:

**1. Assembly Line Build** - Should start immediately
- ⏱️ Takes ~5-7 minutes
- ✅ Builds package
- ✅ Runs Python tests
- ✅ Checks code formatting
- ✅ Validates docstrings
- ✅ Validates DOCX templates
- ✅ Runs ALKiln tests

**2. Playground Deploy** - Starts after build
- ⏱️ Takes ~1-2 minutes
- 🚀 Deploys to playground
- 🚀 Makes code available for testing

**3. Server Monitor** - Will NOT run immediately
- ⏱️ Runs on schedule (6 AM & 6 PM)
- 🏥 Checks server health

---

### ☐ **Step 4: Verify Deployment** (2 minutes)

After workflows complete:

1. **Check Actions Tab**
   - Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions
   - All workflows should have ✅ green checkmarks

2. **Check Playground**
   - Go to: https://docassemble-uugcj-u59651.vm.elestio.app:443/
   - Login
   - Go to **Playground**
   - You should see project: **alkilntests**

3. **Try the Example Interview**
   - In Playground, find `example_motion.yml`
   - Click **"Run"**
   - Walk through the form
   - Verify it works!

---

### ☐ **Step 5: Clone to Your Local Computer** (5 minutes)

**Option A: Using VS Code (Easiest)**

1. Open VS Code
2. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac)
3. Type: `Git: Clone`
4. Paste: `https://github.com/jswizzle3737/docassemble-alkiln-tests.git`
5. Choose a folder
6. Click "Open" when done
7. Install recommended extensions when prompted

**Option B: Using Command Line**

```bash
# Navigate to where you want the code
cd ~/Documents  # or C:\Users\YourName\Documents on Windows

# Clone the repository
git clone https://github.com/jswizzle3737/docassemble-alkiln-tests.git

# Open in VS Code
cd docassemble-alkiln-tests
code .
```

---

### ☐ **Step 6: Verify VS Code Setup** (2 minutes)

Once opened in VS Code:

**Check these exist:**
- ✅ `.vscode/` folder with configuration
- ✅ `.github/workflows/` with 5 workflow files
- ✅ `docassemble/alkilntests/data/questions/example_motion.yml`
- ✅ Documentation files (SUFFOLK_LABS_WORKFLOW.md, etc.)

**Install extensions:**
- VS Code should prompt you to install recommended extensions
- Click **"Install All"**

**Try a task:**
- Press `Ctrl+Shift+P`
- Type: `Tasks: Run Task`
- You should see tasks like "Run Black Formatter", "Open GitHub Actions", etc.

---

## 🎯 **Expected Results**

After completing all steps:

### GitHub Actions
- ✅ Assembly Line Build: PASSING
- ✅ Playground Deploy: SUCCESS
- ✅ All checks green

### Docassemble Playground
- ✅ Project "alkilntests" installed
- ✅ Can run example_motion.yml
- ✅ Interview works correctly

### VS Code
- ✅ Repository cloned locally
- ✅ Extensions installed
- ✅ Can edit files with autocomplete
- ✅ Can run tasks

---

## 📊 **What Gets Deployed**

When you push, these get deployed to your playground:

**Interviews:**
- `test.yml` - Simple test interview
- `example_motion.yml` - Complete Assembly Line motion form

**Test Files:**
- `test_interviews.feature` - Basic tests
- `example_motion_test.feature` - Motion form tests
- `pdf_tests.feature` - 40+ PDF test scenarios

**All files in:**
- `docassemble/alkilntests/data/questions/` → Interview files
- `docassemble/alkilntests/data/templates/` → Document templates
- `docassemble/alkilntests/data/static/` → Static files

---

## 🔍 **Troubleshooting**

### Workflows Fail

**Check:**
1. Is `PROJECT_NAME` secret set correctly?
2. Is `SERVER_URL` secret correct?
3. Is `DOCASSEMBLE_DEVELOPER_API_KEY` valid?

**View logs:**
- Click on failed workflow
- Click on failed job
- Read error message

### Playground Doesn't Show Project

**Try:**
1. Wait 1-2 minutes for deployment to complete
2. Refresh the playground page
3. Check if workflow succeeded in Actions tab
4. Verify `PROJECT_NAME` secret matches playground project

### Can't Push

**Authentication needed:**
- Use GitHub Personal Access Token
- Or set up SSH key
- Or use GitHub Desktop

**Get token:**
1. Go to: https://github.com/settings/tokens
2. Generate new token (classic)
3. Select `repo` and `workflow` scopes
4. Use token as password when pushing

---

## 📝 **Quick Commands Reference**

### Check Status
```bash
git status
git log --oneline -5
```

### Push to GitHub
```bash
git push
```

### Pull Updates
```bash
git pull
```

### View Remotes
```bash
git remote -v
```

---

## 🎉 **Success Indicators**

You'll know everything is working when:

1. ✅ Git push succeeds
2. ✅ GitHub Actions tab shows green checkmarks
3. ✅ Playground shows "alkilntests" project
4. ✅ Can run example_motion.yml in playground
5. ✅ VS Code opens repository with all files
6. ✅ VS Code shows recommended extensions
7. ✅ Can edit and push changes from VS Code

---

## 🚀 **Next Steps After Deployment**

Once everything is deployed:

### 1. Make Your First Edit

In VS Code:
```bash
# Edit the example motion
code docassemble/alkilntests/data/questions/example_motion.yml

# Make a small change
# Save the file
# Commit and push
git add .
git commit -m "test: My first edit"
git push

# Watch it auto-deploy!
```

### 2. Create Your First Interview

```bash
# Create new interview
touch docassemble/alkilntests/data/questions/my_interview.yml

# Edit in VS Code
code docassemble/alkilntests/data/questions/my_interview.yml

# Create tests
touch docassemble/alkilntests/data/sources/my_interview_test.feature

# Commit and push
git add .
git commit -m "feat: Add my interview"
git push
```

### 3. Learn the Workflow

Read these guides in order:
1. `SUFFOLK_LABS_WORKFLOW.md` - Complete workflow
2. `ASSEMBLY_LINE_GUIDE.md` - Assembly Line development
3. `ALKILN_REFERENCE.md` - Testing reference

---

## 📞 **Need Help?**

### Documentation
- **Suffolk LIT Lab:** https://suffolklitlab.org/
- **Assembly Line:** https://suffolklitlab.org/docassemble-AssemblyLine-documentation/
- **ALKiln:** https://assemblyline.suffolklitlab.org/docs/components/ALKiln/
- **Docassemble:** https://docassemble.org/docs.html

### Your Repository
- **Actions:** https://github.com/jswizzle3737/docassemble-alkiln-tests/actions
- **Settings:** https://github.com/jswizzle3737/docassemble-alkiln-tests/settings
- **Issues:** https://github.com/jswizzle3737/docassemble-alkiln-tests/issues

---

## ✅ **Completion Checklist**

Mark these off as you complete them:

- [ ] Step 1: Added PROJECT_NAME secret
- [ ] Step 2: Pushed to GitHub
- [ ] Step 3: Watched workflows run (all passed)
- [ ] Step 4: Verified deployment in playground
- [ ] Step 5: Cloned to local computer
- [ ] Step 6: Verified VS Code setup
- [ ] **BONUS:** Made first test edit and pushed

**When all checked:** You're ready to build Assembly Line interviews! 🎉

---

## 📊 **Current Status Summary**

**Commits Ready to Push:** 3

**What's Included:**
- 5 GitHub Actions workflows
- VS Code configuration (3 files)
- 7 documentation files
- 2 interview files
- 3 test files (.feature)
- Python configuration
- Example Assembly Line motion form

**What Happens When You Push:**
1. Workflows run automatically
2. Code is validated and tested
3. Package deploys to playground
4. Ready to use in minutes!

**Repository:** https://github.com/jswizzle3737/docassemble-alkiln-tests

---

🚀 **Ready to deploy! Start with Step 1!**
