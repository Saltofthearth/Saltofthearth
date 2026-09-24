# Google Cloud Platform (GCP) Always-Free Module
# Configures e2-micro compute VM, Firestore, Cloud Run, and Cloud Functions limits

# 1. VPC Network & Subnet
resource "google_compute_network" "always_free_vpc" {
  name                    = "zero-cost-gcp-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "always_free_subnet" {
  name          = "zero-cost-gcp-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.gcp_region
  network       = google_compute_network.always_free_vpc.id
}

# 2. Always-Free e2-micro Compute Instance (US Regions: us-central1, us-west1, us-east1)
resource "google_compute_instance" "always_free_vm" {
  name         = "gcp-alwaysfree-e2micro"
  machine_type = "e2-micro" # Always-free tier machine type
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30 # Maximum 30 GB standard HDD boot disk
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = google_compute_network.always_free_vpc.id
    subnetwork = google_compute_subnetwork.always_free_subnet.id

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  labels = {
    environment = "always-free"
  }
}

# 3. Always-Free Cloud Storage Bucket (5 GB in US regions)
resource "google_storage_bucket" "always_free_bucket" {
  name                     = "zero-cost-gcp-bucket-${var.project_id}"
  location                 = "US-CENTRAL1"
  storage_class            = "STANDARD"
  force_destroy            = false
  public_access_prevention = "enforced"

  uniform_bucket_level_access = true
}

# 4. Always-Free Cloud Run Service (2 million requests/month)
resource "google_cloud_run_v2_service" "always_free_service" {
  name     = "zero-cost-api-engine"
  location = var.gcp_region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits = {
          cpu    = "1000m" # 1 vCPU
          memory = "512Mi" # Fits well within 180,000 vCPU-seconds / 360,000 GB-seconds free monthly limits
        }
      }
    }
    scaling {
      max_instance_count = 2 # Prevent runaway billing scale
      min_instance_count = 0 # Scale to zero
    }
  }
}

# Inputs & Variables
variable "project_id" { type = string }
variable "gcp_region" { type = string; default = "us-central1" }
variable "gcp_zone" { type = string; default = "us-central1-a" }

# Outputs
output "vm_public_ip" {
  value       = google_compute_instance.always_free_vm.network_interface[0].access_config[0].nat_ip
  description = "GCP Always-Free e2-micro Public IP"
}

output "cloud_run_url" {
  value       = google_cloud_run_v2_service.always_free_service.uri
  description = "GCP Always-Free Cloud Run URL"
}
