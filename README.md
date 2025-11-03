# docassemble-alkiln-tests

This repository tests docassemble interviews using the ALKiln testing framework.

## Quick Start

1. **Add GitHub Secrets** (Required):
   - Go to Settings → Secrets and variables → Actions
   - Add `SERVER_URL`: `https://docassemble-uugcj-u59651.vm.elestio.app/`
   - Add `DOCASSEMBLE_DEVELOPER_API_KEY`: `1gcxf6lPnmwGVlqe2OHIPp2yAkCt25uy`

2. **Update Test File**:
   - Edit `test_interviews.feature`
   - Replace `docassemble.demo:data/questions/hello.yml` with your interview file

3. **Push Changes**:
   - Tests run automatically on push/PR via GitHub Actions

## Files

- `test_interviews.feature` - Main test scenarios using Gherkin syntax
- `.github/workflows/alkiln_tests.yml` - GitHub Actions configuration
- `ALKILN_SETUP.md` - Detailed setup instructions

## Resources

- [ALKiln Documentation](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/alkiln/)
- [Docassemble](https://docassemble.org/)