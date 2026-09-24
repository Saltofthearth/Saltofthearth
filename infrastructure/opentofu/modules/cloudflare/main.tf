# Cloudflare Always-Free Module
# Configures R2 Object Storage (10GB + $0 Egress), D1 Database, Workers KV

# 1. Cloudflare R2 Object Storage Bucket (10 GB Free Storage, Zero Egress)
resource "cloudflare_r2_bucket" "always_free_bucket" {
  account_id = var.account_id
  name       = "zero-cost-cloudflare-r2-storage"
}

# 2. Cloudflare D1 Serverless SQL Database (5 GB Storage, 5M reads/day)
resource "cloudflare_d1_database" "always_free_d1" {
  account_id = var.account_id
  name       = "zero-cost-cloudflare-d1-db"
}

# 3. Cloudflare Workers KV Namespace (1 GB Storage, 100k reads/day)
resource "cloudflare_workers_kv_namespace" "always_free_kv" {
  account_id = var.account_id
  title      = "zero-cost-cloudflare-kv"
}

# Inputs & Variables
variable "account_id" { type = string }

# Outputs
output "r2_bucket_name" {
  value       = cloudflare_r2_bucket.always_free_bucket.name
  description = "Cloudflare R2 Bucket Name"
}

output "d1_database_id" {
  value       = cloudflare_d1_database.always_free_d1.id
  description = "Cloudflare D1 Database ID"
}

output "kv_namespace_id" {
  value       = cloudflare_workers_kv_namespace.always_free_kv.id
  description = "Cloudflare KV Namespace ID"
}
