##################
# create s3 bucket
##################
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
}

################################
# Block public access (Madatory)
################################
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

#########################################
# Enable server side encyrption (SSE-KMS)
#########################################
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.enable_kms ? "aws:kms" : "AES256"
      kms_master_key_id = var.enable_kms ? var.kms_key_arn : null
    }

    bucket_key_enabled = var.enable_kms ? true : false
  }
}

###################
# Enable verisoning
###################
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

#####################################
# Lifecycle rules (Cost + Governance)
#####################################
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(var.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules

    content {
      id     = rule.value.id
      status = rule.value.enabled ? "Enabled" : "Disabled"

      dynamic "transition" {
        for_each = lookup(rule.value, "transition", [])

        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "expiration" {
        for_each = lookup(rule.value, "expiration_days", null) != null ? [1] : []

        content {
          days = rule.value.expiration_days
        }
      }
    }
  }
}

################################################
# Access logging (Optional but production-ready)
################################################
resource "aws_s3_bucket_logging" "this" {
  count  = var.enable_access_logging ? 1 : 0
  bucket = aws_s3_bucket.this.id

  target_bucket = var.access_log_bucket
  target_prefix = var.access_log_prefix
}

###############
# Bucket policy
###############
resource "aws_s3_bucket_policy" "this" {
  count  = var.attach_bucket_policy ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy_json
}
