# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "aws_region" {
  description = "AWS infrastructure region"
  type        = string
  default     = null
}


variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}


variable "enable_key_rotation" {
  description = "(Optional) Specifies whether key rotation is enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "is_enabled" {
  description = "(Optional) Specifies whether the key is enabled. Defaults to true."
  type        = bool
  default     = true
}

# KMS 
variable "customer_master_key_spec" {
  description = "(Optional) Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT."
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

variable "name" {
  description = "kms_name"
  type        = string
  default     = null
}
