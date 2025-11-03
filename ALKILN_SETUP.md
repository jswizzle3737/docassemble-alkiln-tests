# ALKiln Testing Setup for docassemble-alkiln-tests

This repository has been set up with the basic ALKiln testing framework. Here's what has been created and what you need to do next:

## ✅ What's Already Set Up

### 1. GitHub Actions Workflow
- Created `.github/workflows/alkiln_tests.yml`
- Configured to run tests on pushes to main/master and pull requests
- Uses ALKiln v5 action from SuffolkLITLab

### 2. Basic Test File
- Created `test_interviews.feature` with a basic test scenario
- Includes example additional test scenarios (commented out)

## 🔧 Manual Setup Required

⚠️ **IMPORTANT**: The values below are ready to use. You just need to add them as GitHub secrets.

### Step 1: ✅ API Key Ready
Your docassemble API key is ready: `1gcxf6lPnmwGVlqe2OHIPp2yAkCt25uy`

### Step 2: Create GitHub Secrets

1. **Go to your GitHub repository**: https://github.com/jswizzle3737/docassemble-alkiln-tests
2. **Click Settings → Secrets and variables → Actions**
3. **Create these secrets** by clicking "New repository secret":

   - **Name:** `SERVER_URL`
     **Value:** `https://docassemble-uugcj-u59651.vm.elestio.app:443/`

   - **Name:** `DOCASSEMBLE_DEVELOPER_API_KEY`
     **Value:** `1gcxf6lPnmwGVlqe2OHIPp2yAkCt25uy`

### Step 3: Update Test File

1. **Edit `test_interviews.feature`**
2. **Replace `"your_interview_file.yml"`** with your actual interview filename
3. **Add additional test scenarios** as needed for your interviews

### Step 4: Verify Tests Run

After completing the manual setup:

1. **Go to your GitHub repository**
2. **Click the "Actions" tab**
3. **Push a commit** or create a pull request to trigger the workflow
4. **Check the workflow results**

## 📋 Optional Enhancements

### Add Environment Variables
If you need secrets in your tests, modify `.github/workflows/alkiln_tests.yml`:

```yaml
jobs:
  alkiln-tests:
    runs-on: ubuntu-latest
    name: Run ALKiln tests
    env:
      USER_PASSWORD: "${{ secrets.USER_PASSWORD }}"
      MAX_SECONDS_FOR_SETUP: "300"
    steps:
      # ... existing steps
```

### Example Test Scenarios
Uncomment and modify the example test scenarios in `test_interviews.feature`:

- User completion flows
- Form validation testing
- Multi-step interview testing
- Error handling scenarios

## 🔒 Security Notes

- **Never use your production server** for testing
- **Always use GitHub secrets** for API keys and passwords
- **Create a dedicated testing account** on your docassemble server
- **Review the ALKiln documentation** for security best practices

## 🚀 Getting Started

1. Complete the manual setup steps above
2. Update your test file with actual interview names
3. Push changes to trigger your first test run
4. Monitor the Actions tab for test results

## 📚 Resources

- [ALKiln Documentation](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/)
- [ALKiln Setup Guide](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/setup/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docassemble Documentation](https://docassemble.org/docs/)

## 🆘 Need Help?

If you encounter issues:
1. Check the Actions tab for detailed error messages
2. Review the ALKiln documentation
3. Use the automated setup interview: https://apps-dev.suffolklitlab.org/start/setup-alkiln/
4. Contact your docassemble administrator for server-specific questions