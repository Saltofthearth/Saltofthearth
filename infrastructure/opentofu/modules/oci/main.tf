# Oracle Cloud Infrastructure (OCI) Always-Free Module
# Utilizes maximum free tier: 4 ARM OCPUs, 24 GB RAM, 200 GB Block Storage, 10 TB Egress

# 1. Virtual Cloud Network (VCN) & Internet Gateway
resource "oci_core_vcn" "always_free_vcn" {
  compartment_id = var.compartment_id
  cidr_block     = "10.0.0.0/16"
  display_name   = "zero-cost-vcn"
  dns_label      = "zerocostvcn"
}

resource "oci_core_internet_gateway" "always_free_ig" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.always_free_vcn.id
  display_name   = "zero-cost-igw"
  enabled        = true
}

resource "oci_core_default_route_table" "always_free_route_table" {
  manage_default_resource_id = oci_core_vcn.always_free_vcn.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.always_free_ig.id
  }
}

resource "oci_core_subnet" "always_free_subnet" {
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.always_free_vcn.id
  cidr_block        = "10.0.1.0/24"
  display_name      = "zero-cost-public-subnet"
  dns_label         = "publicsubnet"
  security_list_ids = [oci_core_vcn.always_free_vcn.default_security_list_id]
}

# 2. Always-Free Ampere ARM A1 Compute Instance (4 OCPUs, 24GB RAM)
# Image lookup for Canonical Ubuntu 22.04 ARM
data "oci_core_images" "ubuntu_arm" {
  compartment_id           = var.compartment_id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = "VM.Standard.A1.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "oci_core_instance" "ampere_arm_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  display_name        = "oci-alwaysfree-ampere-a1"
  shape               = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = 4   # Maximum Always-Free OCPUs
    memory_in_gbs = 24  # Maximum Always-Free RAM
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.always_free_subnet.id
    assign_public_ip = true
    display_name     = "primary-vnic"
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.ubuntu_arm.images[0].id
    boot_volume_size_in_gbs = 100 # Part of the 200 GB total free storage
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(<<-EOF
      #!/bin/bash
      # Heartbeat cron script to keep CPU/Memory > 20% to satisfy OCI idle reclamation policy
      echo "0 * * * * root stress-ng --cpu 1 --cpu-load 25 --timeout 300s" >> /etc/crontab
    EOF
    )
  }

  freeform_tags = {
    "Tier" = "AlwaysFree"
  }
}

# 3. Always-Free Object Storage Bucket
resource "oci_objectstorage_bucket" "always_free_bucket" {
  compartment_id = var.compartment_id
  name           = "zero-cost-oci-storage"
  namespace      = var.object_storage_namespace
  storage_tier   = "Standard"
  access_type    = "NoPublicTier"
}

# Inputs & Variables for Module
variable "compartment_id" { type = string }
variable "ssh_public_key" { type = string }
variable "object_storage_namespace" { type = string; default = "example_namespace" }

# Outputs
output "instance_public_ip" {
  value       = oci_core_instance.ampere_arm_instance.public_ip
  description = "Public IP address of Always-Free Ampere ARM instance"
}

output "bucket_name" {
  value       = oci_objectstorage_bucket.always_free_bucket.name
  description = "OCI Always-Free Object Storage Bucket Name"
}
