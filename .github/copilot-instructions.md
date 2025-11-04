# Copilot Instructions for docassemble-alkiln-tests

## Project Overview
Suffolk LIT Lab Assembly Line project for building and testing docassemble court form interviews with automated CI/CD deployment.

## Architecture & Key Components

### Suffolk LIT Lab Assembly Line
- **Framework**: Assembly Line v4.2.0 for court form automation
- **Testing**: ALKiln framework (Gherkin/Cucumber) for end-to-end tests
- **CI/CD**: SuffolkLITLab/ALActions for automated builds and deployment
- **Development**: VS Code with Cucumber, Python, and YAML support

### Project Structure
```
docassemble/alkilntests/
  data/
    questions/        # Interview YAML files (example_motion.yml, test.yml)
    sources/          # ALKiln test files (.feature)
    templates/        # DOCX templates for forms
    static/           # CSS, JS, images
```

### Required Secrets
- `SERVER_URL` - Docassemble server URL (test server only)
- `DOCASSEMBLE_DEVELOPER_API_KEY` - API key for deployment

## Critical Workflows

### 5 GitHub Actions Workflows
1. **assembly_line_build.yml** - Main CI/CD (build, test, validate, ALKiln tests)
2. **playground_deploy.yml** - Auto-deploy to playground on push
3. **server_monitor.yml** - Server health monitoring (2x daily)
4. **word_diff.yml** - Word document comparison for PRs
5. **alkiln_tests.yml** - Legacy ALKiln tests

### Development Workflow
1. Edit interviews in VS Code (`docassemble/alkilntests/data/questions/*.yml`)
2. Write tests (`docassemble/alkilntests/data/sources/*.feature`)
3. Format with Black (`Ctrl+Shift+P` → Run Black Formatter)
4. Commit and push
5. Watch workflows run automatically
6. Test in playground after deployment

## Key Files & Documentation

### Essential Documentation
- `DEPLOYMENT_CHECKLIST.md` - Deployment guide
- `SUFFOLK_LABS_WORKFLOW.md` - Complete workflow reference
- `ASSEMBLY_LINE_GUIDE.md` - Assembly Line development
- `ALKILN_REFERENCE.md` - All ALKiln test steps
- `SECURITY.md` - Security policies

### Interview Files
- `example_motion.yml` - Complete Assembly Line motion form example
- `test.yml` - Simple test interview

### Test Files
- `example_motion_test.feature` - Motion form tests
- `pdf_tests.feature` - 40+ PDF test scenarios
- `test_interviews.feature` - Basic interview tests

## Assembly Line Best Practices

### Use Assembly Line Objects
```yaml
objects:
  - users: ALPeopleList.using(ask_number=True)
  - other_parties: ALPeopleList.using(ask_number=True)
  - court_bundle: ALDocumentBundle
```

### Interview Structure
```yaml
include:
  - docassemble.AssemblyLine:assembly_line.yml
---
mandatory: True
code: |
  # Interview order block
  intro_screen
  users[0].name.first
  # ... collect info
  download_screen
```

### Testing with ALKiln
```gherkin
Scenario: Complete form
  Given I start the interview at "example_motion"
  And I get to the question id "signature" with this data:
    | var | value | trigger |
    | users[0].name.first | Jane | |
    | users[0].name.last | Smith | users[0].signature |
  And I sign
  And I continue
  Then I should see the phrase "Your Motion to Continue is ready"
```

## VS Code Integration

### Tasks Available (Ctrl+Shift+P → Tasks)
- Run Black Formatter
- Run Python Unit Tests
- Git: Commit and Push
- Open GitHub Actions
- Deploy to Playground

### Recommended Extensions
- Cucumber (Gherkin syntax)
- Python + Pylance
- Black Formatter
- YAML support
- GitLens

## Security Practices
- Never commit credentials
- Use GitHub secrets only
- Test server only (never production)
- Review SECURITY.md for policies

## Common Patterns
- Assembly Line objects for people, documents, courts
- ALKiln story tables for efficient testing
- PDF regression testing with comparison
- Automatic playground deployment on push