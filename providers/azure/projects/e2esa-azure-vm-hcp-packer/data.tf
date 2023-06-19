data "hcp_packer_iteration" "itr" {
  bucket_name = var.pkr_bucket_name
  channel     = var.channel
}

data "hcp_packer_image" "pkr-img" {
  bucket_name    = var.pkr_bucket_name
  iteration_id   = data.hcp_packer_iteration.itr.id
  cloud_provider = var.cloud_provider
  region         = var.az_region_parent_img
}