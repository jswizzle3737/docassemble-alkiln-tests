# Copilot Instructions for docassemble-alkiln-tests

## Project Overview
This repository is set up for testing docassemble interviews using the ALKiln testing framework. It's a specialized end-to-end testing environment for legal document automation interviews.

## Architecture & Key Components

### ALKiln Testing Framework
- **Primary test file**: `test_interviews.feature` - Uses Gherkin syntax for behavior-driven testing
- **GitHub Actions**: `.github/workflows/alkiln_tests.yml` - Automated testing on pushes/PRs using SuffolkLITLab/ALKiln@v5
- **Target**: Tests actual docassemble interview YAML files on a remote server

### Required Secrets
The project requires these GitHub repository secrets to function:
- `SERVER_URL` - Docassemble testing server URL (never production)
- `DOCASSEMBLE_DEVELOPER_API_KEY` - API key from the docassemble server

## Critical Workflows

### Test Development Pattern
1. Replace `"your_interview_file.yml"` with actual interview filenames in feature files
2. Use Gherkin steps like:
   - `Given I start the interview at "filename.yml"`
   - `And I set the var "variable_name" to "value"`
   - `And I continue`
   - `Then I should see the phrase "expected text"`

### Environment Setup
- Follow `ALKILN_SETUP.md` for initial configuration
- Always use a dedicated testing server, never production
- Test files trigger on pushes to main/master and pull requests

## Project-Specific Conventions

### Test File Structure
- `.feature` files use Gherkin syntax
- Each scenario tests a specific interview flow or validation
- Comments show example patterns for common testing scenarios
- Focus on user journey testing rather than unit tests

### Security Practices
- All server credentials stored as GitHub secrets
- Testing server separate from production environment
- API keys created specifically for testing purposes

## Development Commands
- Tests run automatically via GitHub Actions
- Manual testing requires docassemble server access
- No local build commands - this is pure integration testing

## Key Files to Understand
- `ALKILN_SETUP.md` - Complete setup instructions and security guidelines
- `test_interviews.feature` - Main test definitions with example patterns
- `.github/workflows/alkiln_tests.yml` - CI/CD configuration for ALKiln framework

## Integration Points
- **External dependency**: Docassemble server for interview execution
- **Testing framework**: ALKiln (SuffolkLITLab) for browser automation
- **CI/CD**: GitHub Actions for automated test execution
- **Target files**: Docassemble YAML interview files (not in this repo)

## Common Patterns
When adding new tests, follow the existing scenario structure and use the commented examples in `test_interviews.feature` as templates for user flows, validation testing, and multi-step interviews.