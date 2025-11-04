# 🚀 Deployment Guide

Simple steps to deploy your Suffolk LIT Lab Assembly Line workflow.

---

## ✅ **Current Status**

- ✅ 4 commits ready to push
- ✅ All files created and configured
- ✅ VS Code configuration complete
- ✅ Documentation complete
- ⏳ Ready to push to GitHub

---

## 📋 **Deployment Steps**

### Step 1: Push to GitHub

Push your commits from your local machine:

```bash
# If you already have the repository locally:
cd /path/to/docassemble-alkiln-tests
git pull origin main
git push

# OR clone it first:
git clone https://github.com/jswizzle3737/docassemble-alkiln-tests.git
cd docassemble-alkiln-tests
git push
```

**That's it!** The workflows will run automatically.

---

### Step 2: Watch It Deploy (5-10 minutes)

Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions

You'll see workflows start automatically:

1. **Assembly Line Build** (~5-7 minutes)
   - Builds and validates your package
   - Runs tests
   - Checks code formatting

2. **Playground Deploy** (~1-2 minutes)
   - Automatically deploys to your playground
   - Makes code available for testing

---

### Step 3: Test in Playground

1. Go to: https://docassemble-uugcj-u59651.vm.elestio.app:443/
2. Login and go to **Playground**
3. Find project: **alkilntests**
4. Run `example_motion.yml`

---

## 🎯 **What Gets Deployed**

When you push, these are automatically deployed to your playground:

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

### Workflows Fail?

**Check your GitHub Secrets:**
1. Go to: https://github.com/jswizzle3737/docassemble-alkiln-tests/settings/secrets/actions
2. Verify these secrets exist:
   - `SERVER_URL` - Your docassemble server URL
   - `DOCASSEMBLE_DEVELOPER_API_KEY` - Your API key

**View error logs:**
- Click on the failed workflow
- Click on the failed job
- Read the error message

### Can't Push?

**Need authentication:**
- Use GitHub Personal Access Token
- Or set up SSH key
- Or use GitHub Desktop

**Get a token:**
1. Go to: https://github.com/settings/tokens
2. Generate new token (classic)
3. Select `repo` and `workflow` scopes
4. Use token as password when pushing

---

## 💻 **Clone to VS Code**

After pushing, clone to your local machine to start developing:

### Option A: Using VS Code

1. Open VS Code
2. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac)
3. Type: `Git: Clone`
4. Paste: `https://github.com/jswizzle3737/docassemble-alkiln-tests.git`
5. Choose a folder
6. Click "Open" when done
7. Install recommended extensions when prompted

### Option B: Using Command Line

```bash
cd ~/Documents  # or your preferred location
git clone https://github.com/jswizzle3737/docassemble-alkiln-tests.git
cd docassemble-alkiln-tests
code .
```

---

## 🎉 **Success Indicators**

You'll know everything is working when:

1. ✅ Git push succeeds
2. ✅ GitHub Actions tab shows green checkmarks
3. ✅ Playground shows "alkilntests" project
4. ✅ Can run example_motion.yml in playground
5. ✅ VS Code opens repository with all files

---

## 🚀 **Next Steps After Deployment**

### Make Your First Edit

In VS Code:
```bash
# Edit the example motion
code docassemble/alkilntests/data/questions/example_motion.yml

# Make a small change, save, then commit
git add .
git commit -m "test: My first edit"
git push

# Watch it auto-deploy!
```

### Learn the Workflow

Read these guides:
1. `SUFFOLK_LABS_WORKFLOW.md` - Complete workflow overview
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

---

## ✅ **Quick Checklist**

- [ ] Pushed to GitHub
- [ ] Watched workflows run (all passed)
- [ ] Verified deployment in playground
- [ ] Cloned to local computer
- [ ] Opened in VS Code
- [ ] Installed recommended extensions

**When all checked:** You're ready to build Assembly Line interviews! 🎉
