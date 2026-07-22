bucket_name = "my-unit-test-bucket-2026"
tags = {
  Environment = "UnitTest"
  Project     = "S3Module"
}

block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true

enable_versioning     = false
enable_kms            = false
kms_key_arn           = ""
lifecycle_rules       = []
enable_access_logging = false
access_log_bucket     = ""
access_log_prefix     = ""
attach_bucket_policy  = false
bucket_policy_json    = ""
