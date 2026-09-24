# Global Variables for Zero-Cost Multicloud Setup

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "production"
}

# ------------------------------------------------------------------------------
# OCI Variables
# ------------------------------------------------------------------------------
variable "oci_tenancy_ocid" {
  type        = string
  description = "OCI Tenancy OCID"
  default     = "ocid1.tenancy.oc1..example"
}

variable "oci_user_ocid" {
  type        = string
  description = "OCI User OCID"
  default     = "ocid1.user.oc1..example"
}

variable "oci_fingerprint" {
  type        = string
  description = "OCI Fingerprint"
  default     = "00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"
}

variable "oci_private_key_path" {
  type        = string
  description = "Path to OCI API Private Key"
  default     = "~/.oci/oci_api_key.pem"
}

variable "oci_region" {
  type        = string
  description = "OCI Region (e.g. us-ashburn-1, us-phoenix-1)"
  default     = "us-ashburn-1"
}

variable "oci_compartment_ocid" {
  type        = string
  description = "OCI Compartment OCID for always-free resources"
  default     = "ocid1.compartment.oc1..example"
}

variable "oci_ssh_public_key" {
  type        = string
  description = "SSH Public Key for OCI Compute Instance access"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ..."
}

# ------------------------------------------------------------------------------
# GCP Variables
# ------------------------------------------------------------------------------
variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID"
  default     = "zero-cost-multicloud-project"
}

variable "gcp_region" {
  type        = string
  description = "GCP Region for Always-Free Compute (us-central1, us-west1, or us-east1)"
  default     = "us-central1"
}

variable "gcp_zone" {
  type        = string
  description = "GCP Zone for Compute Engine"
  default     = "us-central1-a"
}

# ------------------------------------------------------------------------------
# AWS Variables
# ------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "AWS Primary Region"
  default     = "us-east-1"
}

# ------------------------------------------------------------------------------
# Cloudflare Variables
# ------------------------------------------------------------------------------
variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API Token with Workers, R2, and D1 permissions"
  default     = "example_cloudflare_token"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare Account ID"
  default     = "example_account_id"
}

# ------------------------------------------------------------------------------
# GitHub Variables
# ------------------------------------------------------------------------------
variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
  default     = "ghp_example"
}

variable "github_owner" {
  type        = string
  description = "GitHub Repository Owner or Organization"
  default     = "Saltofthearth"
}
