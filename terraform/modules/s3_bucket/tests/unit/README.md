## Unit tests

These inspect the Terraform plan without creating AWS resources.

Examples:

- bucket name
- tags
- versioning enabled
- encryption configuration
- lifecycle configuration
- outputs

Fast to run in CI.

| Resource            | Test                                      |
| ------------------- | ----------------------------------------- |
| aws_s3_bucket       | bucket created with correct name and tags |
| public access block | all four flags set correctly              |
| encryption          | AES256 vs KMS                             |
| versioning          | Enabled / Suspended                       |
| lifecycle           | lifecycle exists only when rules provided |
| logging             | logging exists only when enabled          |
| bucket policy       | policy attached only when requested       |

Notice we're **testing module behavior**, not AWS itself.

---

## Fixtures

Each fixture represents one configuration.

Example

```bash
tests/
    fixtures/
        minimal/
        kms/
        versioning/
        lifecycle/
        logging/
        bucket_policy/
```

For example,

**minimal**

```terraform
bucket_name           = "my-unit-test-bucket-2026"
tags                  = {
  Environment = "UnitTest"
  Project     = "S3Module"
}
```

**test_bucket.py**

This verifies the bucket itself.

Test cases

```bash
✓ bucket exists

✓ bucket name matches

✓ tags applied
```
