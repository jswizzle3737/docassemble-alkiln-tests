# Security Policy

## ⚠️ Credential Management

### CRITICAL: Never Commit Credentials

**DO NOT** commit any of the following to this repository:
- API keys
- Server URLs (if they contain identifying information)
- Passwords
- Access tokens
- Any other sensitive information

### Proper Credential Storage

✅ **CORRECT:** Store credentials as GitHub Secrets
- Go to: Repository Settings → Secrets and variables → Actions
- Add secrets: `SERVER_URL` and `DOCASSEMBLE_DEVELOPER_API_KEY`
- Reference them in workflows using `${{ secrets.SECRET_NAME }}`

❌ **WRONG:**
- Hardcoding credentials in documentation files
- Committing credentials in code
- Sharing credentials in issues or pull requests

## 🚨 If Credentials Were Exposed

If you've accidentally committed credentials to this repository:

### Immediate Actions:

1. **Revoke the exposed credentials immediately**
   - Log into your docassemble server
   - Go to: User menu → API keys
   - Delete the exposed API key
   - Generate a new one

2. **Remove credentials from git history**
   ```bash
   # Option 1: Using BFG Repo-Cleaner (recommended)
   # Download from: https://rtyley.github.io/bfg-repo-cleaner/
   java -jar bfg.jar --replace-text passwords.txt

   # Option 2: Using git filter-branch
   git filter-branch --force --index-filter \
   'git rm --cached --ignore-unmatch path/to/file' \
   --prune-empty --tag-name-filter cat -- --all
   ```

3. **Force push the cleaned history**
   ```bash
   git push --force --all
   ```

4. **Add new credentials as secrets**
   - Never commit them again
   - Use GitHub Secrets exclusively

## Best Practices

### Test Server Requirements

- ✅ **Use a dedicated test server** - Never use production
- ✅ **Create a test account** - Dedicated for automated testing only
- ✅ **Limit permissions** - Test account should have minimal required access
- ✅ **Regular rotation** - Rotate API keys periodically
- ✅ **Monitor access** - Review server logs for unusual activity

### GitHub Actions Security

- ✅ Only add secrets in repository settings
- ✅ Never log or echo secret values in workflows
- ✅ Review workflow files before running
- ✅ Limit workflow permissions to minimum required
- ✅ Use `GITHUB_TOKEN` for GitHub API access when possible

### Public Repository Warnings

If this repository is public:
- Extra caution with any committed content
- Assume all content is visible to everyone
- Consider making the repository private if it contains interview logic you want to protect
- Never commit test data that contains real personal information

## Reporting Security Issues

If you discover a security vulnerability in this repository:

1. **DO NOT** open a public issue
2. Contact the repository owner directly
3. Provide details about the vulnerability
4. Allow time for the issue to be addressed before public disclosure

## Additional Resources

- [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [ALKiln Security Docs](https://assemblyline.suffolklitlab.org/docs/components/ALKiln/security/)
- [Docassemble Security](https://docassemble.org/docs/security.html)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
