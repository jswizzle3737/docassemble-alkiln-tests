# 🚀 HOW TO RUN THE CODE

This document explains all the ways to execute and test the code in this repository.

---

## ⚡ Quick Answer

### Local Execution (Works Now) ✅
```bash
# Run comprehensive demonstration
./run_demo.sh

# Or just verify setup
./verify_setup.sh
```

### GitHub Actions (Needs Configuration) ⚠️
**Status**: Currently failing with "startup_failure"  
**Reason**: Missing GitHub repository secrets  
**Fix**: See [FIX_GITHUB_ACTIONS.md](./FIX_GITHUB_ACTIONS.md)

---

## 📋 Execution Methods

### Method 1: Local Validation Scripts ✅ WORKING

#### Run Complete Demonstration
```bash
chmod +x run_demo.sh
./run_demo.sh
```

**What it does:**
- Runs setup verification
- Validates Python package structure
- Displays test configuration
- Shows interview files
- Displays GitHub Actions configuration
- Provides execution summary

**Output:** Comprehensive report of all components

#### Run Setup Verification Only
```bash
chmod +x verify_setup.sh
./verify_setup.sh
```

**What it does:**
- Checks all required files exist
- Validates test file has content
- Confirms workflow is configured
- Verifies ALKiln v5 is specified

**Output:** Checklist of setup validation

---

### Method 2: Python Package Validation ✅ WORKING

#### Check Package Version
```bash
python3 setup.py --version
```

#### Test Package Import
```bash
python3 -c "from docassemble.alkilntests import __version__; print(f'Version: {__version__}')"
```

**What it validates:**
- Package structure is correct
- `__init__.py` files are present
- Version information is accessible
- Python namespace packaging works

---

### Method 3: GitHub Actions Testing ❌ NOT WORKING

#### Current Status
- **Status**: startup_failure
- **Jobs**: 0 executed  
- **Issue**: Missing required secrets

#### What's Configured
✅ Workflow file: `.github/workflows/alkiln_tests.yml`  
✅ Triggers: Push to main/master, Pull requests  
✅ Framework: ALKiln v5 from SuffolkLITLab  
❌ Secrets: NOT configured

#### Required Secrets (Missing)
```
SERVER_URL                      - Your docassemble testing server URL
DOCASSEMBLE_DEVELOPER_API_KEY   - API key from docassemble server
```

#### How to Fix
**See detailed instructions in [FIX_GITHUB_ACTIONS.md](./FIX_GITHUB_ACTIONS.md)**

Quick steps:
1. Go to repository Settings → Secrets and variables → Actions
2. Add `SERVER_URL` (format: `https://server.example.com:443/`)
3. Add `DOCASSEMBLE_DEVELOPER_API_KEY` (from your docassemble server)
4. Push a commit to trigger tests

#### Once Fixed, Tests Will Run On:
- Every push to `main` or `master` branch
- Every pull request to `main` or `master` branch
- Manual workflow dispatch

#### View Test Results
https://github.com/jswizzle3737/docassemble-alkiln-tests/actions

---

## 🎯 What Each Method Tests

### Local Scripts
✅ File structure is correct  
✅ Required files exist  
✅ Configuration files are valid  
✅ Python package is importable  
✅ Documentation is present  

❌ Cannot test actual interview execution  
❌ Cannot test docassemble integration  
❌ Cannot run browser automation tests  

### GitHub Actions (When Working)
✅ Everything local scripts test, PLUS:  
✅ Actual interview execution on docassemble server  
✅ Browser automation with ALKiln  
✅ End-to-end user workflow testing  
✅ Integration with docassemble API  
✅ Continuous testing on every change  

---

## 📊 Current Status Summary

| Method | Status | Notes |
|--------|--------|-------|
| `./verify_setup.sh` | ✅ Working | Validates setup locally |
| `./run_demo.sh` | ✅ Working | Full local demonstration |
| Python package | ✅ Working | Package structure valid |
| GitHub Actions | ❌ Failing | Needs secrets configuration |

---

## 🔍 Troubleshooting

### "Permission denied" when running scripts
```bash
chmod +x verify_setup.sh run_demo.sh
./verify_setup.sh
```

### "Module not found" when importing package
```bash
# Add current directory to Python path
python3 -c "import sys; sys.path.insert(0, '.'); from docassemble.alkilntests import __version__; print(__version__)"
```

### GitHub Actions showing "startup_failure"
This is the current issue. Follow [FIX_GITHUB_ACTIONS.md](./FIX_GITHUB_ACTIONS.md) to resolve.

### Want to test locally without docassemble server?
Use the local scripts (`verify_setup.sh` and `run_demo.sh`). They don't require a server.

---

## 🎓 Understanding the Architecture

This repository has two execution modes:

### 1. Local Development Mode (Current)
- **Purpose**: Validate structure and configuration
- **Requires**: Python 3, bash
- **Tests**: File structure, package setup
- **Use case**: Development and validation

### 2. Integration Testing Mode (Requires Setup)
- **Purpose**: Test actual interview workflows
- **Requires**: Docassemble server, GitHub secrets
- **Tests**: Full user workflows, browser automation
- **Use case**: Continuous integration, end-to-end testing

---

## ✅ Next Steps

1. **To run locally**: Just execute `./run_demo.sh`
2. **To fix GitHub Actions**: Follow [FIX_GITHUB_ACTIONS.md](./FIX_GITHUB_ACTIONS.md)
3. **To learn more**: Read [README.md](./README.md) and [GETTING_STARTED.md](./GETTING_STARTED.md)

---

## 📚 Additional Resources

- [FIX_GITHUB_ACTIONS.md](./FIX_GITHUB_ACTIONS.md) - Fix GitHub Actions
- [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) - Common issues
- [QUICK_START.md](./QUICK_START.md) - Quick start guide
- [ALKiln Documentation](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/) - Test framework docs

---

**Last Updated**: 2025-11-03  
**Status**: Local execution working, GitHub Actions needs configuration
