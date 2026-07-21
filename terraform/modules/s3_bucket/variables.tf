###################
# initialize bucket
###################
variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "tags" {
  description = "Standard tags applied to the bucket"
  type        = map(string)
  default     = {}
}

#####################
# block public access
#####################
variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

########################
# server side encryption
########################
variable "enable_kms" {
  type        = bool
  description = "Set to true in production to use custom KMS encryption"
  default     = false
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key (required only if enable_kms is true)"
  default     = null
}

############
# versioning
############
variable "enable_versioning" {
  description = "Enable S3 versioning for S3 bucket"
  type        = bool
  default     = true
}

#########################
# buckets lifecycle rules
#########################
variable "lifecycle_rules" {
  description = "Lifecycle rules for the bucket"
  type = list(object({
    id      = string
    enabled = bool

    transition = optional(list(object({
      days          = number
      storage_class = string
    })))

    expiration_days = optional(number)
  }))
  default = []
}

################
# access logging
################
variable "enable_access_logging" {
  description = "Enable access logging"
  type        = bool
  default     = false
}

variable "access_log_bucket" {
  description = "Bucket where access logs are stored"
  type        = string
  default     = null
}

variable "access_log_prefix" {
  description = "Prefix for access logs"
  type        = string
  default     = null
}

###############
# bucket policy
###############
variable "attach_bucket_policy" {
  description = "Whether to attch a bucjet policy"
  type        = bool
  default     = false
}

variable "bucket_policy_json" {
  description = "Bucket policy JSON"
  type        = string
  default     = null
}
