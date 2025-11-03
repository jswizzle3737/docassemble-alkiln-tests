# Contributing to docassemble-alkiln-tests

Thank you for your interest in improving this testing repository! This guide will help you contribute effectively.

## 🎯 Ways to Contribute

### 1. Add New Test Scenarios
- Share useful test patterns you've developed
- Add edge cases or complex scenarios
- Document tricky testing situations

### 2. Improve Documentation
- Fix typos or unclear instructions
- Add examples for common use cases
- Improve troubleshooting guides

### 3. Report Issues
- Document problems with setup or testing
- Report bugs in test execution
- Suggest improvements to structure

### 4. Share Best Practices
- Document testing strategies that work well
- Share tips for organizing large test suites
- Contribute performance optimization techniques

## 📝 Adding Test Examples

### Before Adding a New Test Pattern

1. **Check existing examples** in `test_examples/` directory
2. **Ensure it's reusable** - not specific to one interview
3. **Document the use case** - explain when to use this pattern

### Test Example Guidelines

```gherkin
# ✅ Good: Generic, reusable pattern with clear documentation
# Pattern: Multi-step form with validation
Scenario: User completes validated multi-step form
  Given I start the interview at "your_interview_name"
  And I set the var "email" to "user@example.com"
  And I continue
  Then I should see the phrase "Next page"

# ❌ Bad: Too specific to one interview
Scenario: User completes the XYZ Corp intake form
  Given I start the interview at "xyz_corp_intake"
  And I set the var "xyz_employee_id" to "12345"
```

### Where to Add Examples

| Test Type | File to Update |
|---|---|
| Simple forms, basic navigation | `test_examples/basic_tests.feature` |
| If/then logic, branching | `test_examples/conditional_logic_tests.feature` |
| Multi-page flows | `test_examples/multi_page_tests.feature` |
| Button interactions | `test_examples/button_navigation_tests.feature` |
| Validation, error messages | `test_examples/validation_tests.feature` |
| New category | Create new file in `test_examples/` |

## 📚 Improving Documentation

### Documentation Files

- **README.md** - Main entry point, quick start guide
- **GETTING_STARTED.md** - Step-by-step setup for new users
- **ALKILN_SETUP.md** - Detailed setup instructions
- **TROUBLESHOOTING.md** - Common issues and solutions
- **.github/QUICK_REFERENCE.md** - Syntax cheatsheet
- **test_examples/README.md** - Guide to using test examples

### Documentation Guidelines

1. **Be concise** - Users want quick answers
2. **Use examples** - Show, don't just tell
3. **Consider beginners** - Don't assume ALKiln/docassemble knowledge
4. **Keep it current** - Update when ALKiln or docassemble change

### Documentation Style

```markdown
# ✅ Good: Clear, actionable, with example

## Setting Variable Values
Use exact quotes around all values:
```gherkin
And I set the var "age" to "25"
```

# ❌ Bad: Vague, no example

## Setting Variable Values
Make sure you set variables correctly using the proper syntax.
```

## 🔧 Technical Contributions

### Repository Structure

```
.
├── .github/
│   ├── workflows/
│   │   └── alkiln_tests.yml          # CI/CD configuration
│   ├── QUICK_REFERENCE.md            # Syntax cheatsheet
│   └── copilot-instructions.md        # AI assistant guidance
├── docassemble/
│   └── alkilntests/
│       └── data/
│           ├── questions/             # Sample interviews
│           ├── templates/             # Document templates
│           └── static/                # Static assets
├── test_examples/                     # 📁 Categorized test patterns
│   ├── README.md                      # Example usage guide
│   ├── basic_tests.feature
│   ├── conditional_logic_tests.feature
│   ├── multi_page_tests.feature
│   ├── button_navigation_tests.feature
│   └── validation_tests.feature
├── test_interviews.feature            # Main test file (users edit)
├── README.md                          # Main documentation
├── GETTING_STARTED.md                 # Setup walkthrough
├── ALKILN_SETUP.md                   # Detailed setup
├── TROUBLESHOOTING.md                 # Issue resolution
├── CONTRIBUTING.md                    # This file
└── setup.py                           # Package configuration
```

### Adding New Example Categories

If you have test patterns that don't fit existing categories:

1. **Create new feature file** in `test_examples/`
   ```bash
   test_examples/your_category_tests.feature
   ```

2. **Follow naming convention**: `{category}_tests.feature`

3. **Add header comment** explaining the category:
   ```gherkin
   # Your Category Test Scenarios
   # Use these patterns to test [specific use case]
   
   Feature: Your Category Tests
   ```

4. **Update test_examples/README.md** with new category

5. **Document in main README.md** if it's a major addition

## 🐛 Reporting Issues

### Before Reporting

1. Check **TROUBLESHOOTING.md** for known issues
2. Search existing GitHub issues
3. Try with a minimal test case

### Good Issue Reports Include

- **Clear title**: "Tests fail with 'connection refused' error"
- **Environment**: ALKiln version, docassemble version
- **Steps to reproduce**: Exact test code that fails
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Error messages**: Full error output

### Example Issue Template

```markdown
## Problem
Tests fail when using multi-line text values

## Environment
- ALKiln: v5
- Docassemble: 1.4.80

## Test Code
```gherkin
Scenario: Set multi-line text
  Given I start the interview at "test"
  And I set the var "notes" to "Line 1
  Line 2"
```

## Expected
Variable should be set with newline

## Actual
Error: "Unexpected token"

## Additional Context
Works fine with single-line text
```

## ✅ Pull Request Guidelines

### Before Submitting

- [ ] Test your changes work correctly
- [ ] Update relevant documentation
- [ ] Follow existing code style
- [ ] Keep changes focused (one issue per PR)
- [ ] Write clear commit messages

### PR Description Template

```markdown
## What This Changes
Brief description of the change

## Why This Is Useful
Explain the problem this solves

## Testing Done
- [ ] Tested on local docassemble server
- [ ] Verified with example interview
- [ ] Checked documentation renders correctly

## Related Issues
Closes #123
```

### Commit Message Style

```bash
# ✅ Good: Clear, specific
Add validation test pattern for email format
Update TROUBLESHOOTING.md with API key regeneration steps

# ❌ Bad: Vague
Update files
Fix stuff
```

## 🔒 Security Considerations

### Never Commit

- ❌ API keys or passwords
- ❌ Server URLs for production systems
- ❌ Real user data or PII
- ❌ Interview files with sensitive content

### Always Use

- ✅ Placeholder values in examples
- ✅ GitHub secrets for credentials
- ✅ Test/development servers only
- ✅ Sanitized example data

### If You Find Security Issues

**Do NOT** open a public issue. Instead:
1. Email the repository maintainer privately
2. Describe the issue clearly
3. Wait for acknowledgment before disclosure

## 📞 Getting Help

- **Documentation**: Start with README.md and GETTING_STARTED.md
- **ALKiln Issues**: [SuffolkLITLab/ALKiln GitHub](https://github.com/SuffolkLITLab/ALKiln/issues)
- **Docassemble Help**: [Docassemble Slack](https://docassemble.org/docs/support.html)
- **This Repository**: Open a GitHub issue with questions

## 🙏 Thank You

Your contributions help make docassemble testing more accessible and effective for everyone. Whether you're fixing a typo, adding a test example, or improving documentation - every contribution matters!

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License, matching this repository's license.
