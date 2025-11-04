#!/bin/bash
# Demonstration script showing how to "run the code" in this repository
# This ALKiln testing framework has multiple execution methods

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  ALKiln Testing Framework - Code Execution Demonstration      ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Method 1: Verify Setup
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Method 1: Running Setup Verification"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
./verify_setup.sh
echo ""

# Method 2: Validate Python Package
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Method 2: Validating Python Package"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Package Name: docassemble.alkilntests"
python3 setup.py --version | head -1 | sed 's/^/Package Version: /'
echo ""
echo "Testing package import..."
python3 -c "import sys; sys.path.insert(0, '.'); from docassemble.alkilntests import __version__; print(f'✅ Successfully imported package version {__version__}')"
echo ""

# Method 3: Display Test Configuration
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Method 3: Displaying Test Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Test File: test_interviews.feature"
echo "Content:"
echo "----------------------------------------"
head -11 test_interviews.feature
echo "----------------------------------------"
echo ""

# Method 4: Show Interview File
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Method 4: Displaying Interview Files"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Interview file: docassemble/alkilntests/data/questions/test.yml"
echo "Content:"
echo "----------------------------------------"
cat docassemble/alkilntests/data/questions/test.yml
echo "----------------------------------------"
echo ""

# Method 5: GitHub Actions Status
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Method 5: GitHub Actions Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Workflow File: .github/workflows/alkiln_tests.yml"
echo "Content:"
echo "----------------------------------------"
cat .github/workflows/alkiln_tests.yml
echo "----------------------------------------"
echo ""

# Summary
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  SUMMARY: How to Run This Code                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "✅ Local Execution (This Script):"
echo "   • Setup verification: ./verify_setup.sh"
echo "   • Python package validation: python3 setup.py --version"
echo "   • Package import test: python3 -c 'from docassemble.alkilntests import __version__'"
echo ""
echo "✅ Automated Testing (GitHub Actions):"
echo "   • Push to main/master branch → Tests run automatically"
echo "   • Create a pull request → Tests run automatically"
echo "   • View results: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions"
echo ""
echo "✅ Prerequisites for GitHub Actions:"
echo "   • SERVER_URL secret must be configured"
echo "   • DOCASSEMBLE_DEVELOPER_API_KEY secret must be configured"
echo "   • See ALKILN_SETUP.md for setup instructions"
echo ""
echo "✅ All local validations passed successfully!"
echo ""
