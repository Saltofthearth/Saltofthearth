# Root Module Outputs for Zero-Cost Multicloud

output "oci_instance_ip" {
  value       = module.oci_free_tier.instance_public_ip
  description = "OCI Always Free Ampere ARM Instance Public IP"
}

output "gcp_vm_ip" {
  value       = module.gcp_free_tier.vm_public_ip
  description = "GCP Always Free e2-micro Public IP"
}

output "gcp_cloud_run_endpoint" {
  value       = module.gcp_free_tier.cloud_run_url
  description = "GCP Cloud Run Free Endpoint URL"
}

output "aws_dynamodb_table" {
  value       = module.aws_free_tier.dynamodb_table_name
  description = "AWS Always Free DynamoDB Table"
}

output "cloudflare_r2_bucket" {
  value       = module.cloudflare_free_tier.r2_bucket_name
  description = "Cloudflare R2 Bucket Name (Zero Egress)"
}
