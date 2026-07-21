## Integration tests

These apply the Terraform configuration to AWS, verify the resulting infrastructure, and then destroy it.

Examples:

- bucket actually exists
- versioning is enabled
- KMS encryption is configured
- lifecycle rules are present
- bucket policy is attached

These are slower and may run only in selected CI pipelines or before releases.
