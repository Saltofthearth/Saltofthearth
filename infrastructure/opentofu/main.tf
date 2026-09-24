# Root Infrastructure Composition Module
# Orchestrates all zero-cost provider modules within always-free quotas

module "oci_free_tier" {
  source = "./modules/oci"

  compartment_id = var.oci_compartment_ocid
  ssh_public_key = var.oci_ssh_public_key
}

module "gcp_free_tier" {
  source = "./modules/gcp"

  project_id = var.gcp_project_id
  gcp_region = var.gcp_region
  gcp_zone   = var.gcp_zone
}

module "aws_free_tier" {
  source = "./modules/aws"
}

module "cloudflare_free_tier" {
  source = "./modules/cloudflare"

  account_id = var.cloudflare_account_id
}

module "github_free_tier" {
  source = "./modules/github"
}

# Root Outputs
output "oci_ampere_public_ip" {
  value       = module.oci_free_tier.instance_public_ip
  description = "OCI Ampere ARM Always-Free Instance IP"
}

output "gcp_e2micro_public_ip" {
  value       = module.gcp_free_tier.vm_public_ip
  description = "GCP e2-micro Always-Free Instance IP"
}

output "gcp_cloud_run_url" {
  value       = module.gcp_free_tier.cloud_run_url
  description = "GCP Cloud Run Endpoint URL"
}

output "aws_dynamodb_table" {
  value       = module.aws_free_tier.dynamodb_table_name
  description = "AWS DynamoDB Table Name"
}

output "cloudflare_r2_bucket" {
  value       = module.cloudflare_free_tier.r2_bucket_name
  description = "Cloudflare R2 Bucket Name"
}
