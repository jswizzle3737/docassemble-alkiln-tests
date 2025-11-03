#!/bin/bash
# This script helps verify your ALKiln setup is correct
# Run it to check that all necessary files and configurations exist

set -e

echo "🧪 ALKiln Setup Verification"
echo "=============================="
echo ""

# Check 1: Required files exist
echo "✓ Checking required files..."
files=(
    "test_interviews.feature"
    ".github/workflows/alkiln_tests.yml"
    "setup.py"
    "GETTING_STARTED.md"
    "README.md"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file - MISSING!"
    fi
done

echo ""

# Check 2: test_interviews.feature has content
echo "✓ Checking test file content..."
if grep -q "Feature:" test_interviews.feature; then
    echo "  ✅ test_interviews.feature contains Feature:"
else
    echo "  ❌ test_interviews.feature is empty!"
fi

if grep -q "Given I start the interview at" test_interviews.feature; then
    echo "  ✅ test_interviews.feature contains test scenarios"
else
    echo "  ❌ test_interviews.feature has no scenarios!"
fi

echo ""

# Check 3: Workflow file has required steps
echo "✓ Checking workflow file..."
if grep -q "SuffolkLITLab/ALKiln@v5" .github/workflows/alkiln_tests.yml; then
    echo "  ✅ Workflow uses ALKiln v5"
else
    echo "  ❌ Workflow doesn't use ALKiln v5!"
fi

if grep -q "SERVER_URL" .github/workflows/alkiln_tests.yml; then
    echo "  ✅ Workflow has SERVER_URL secret"
else
    echo "  ❌ Workflow missing SERVER_URL!"
fi

if grep -q "DOCASSEMBLE_DEVELOPER_API_KEY" .github/workflows/alkiln_tests.yml; then
    echo "  ✅ Workflow has API key secret"
else
    echo "  ❌ Workflow missing API key!"
fi

echo ""
echo "=============================="
echo "✅ Setup verification complete!"
echo ""
echo "Next steps:"
echo "1. Add GitHub secrets: Settings → Secrets and variables → Actions"
echo "   - SERVER_URL: Your docassemble testing server URL"
echo "   - DOCASSEMBLE_DEVELOPER_API_KEY: Your API key from the server"
echo "2. Update interview filename in test_interviews.feature"
echo "3. Push changes: git push origin main"
echo "4. Check results: https://github.com/jswizzle3737/docassemble-alkiln-tests/actions"
echo ""
