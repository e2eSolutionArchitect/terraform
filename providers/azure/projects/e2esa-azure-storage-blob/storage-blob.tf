
module "az_storage_blob" {
  source = "../../modules/e2esa-module-azure-storage-blob"
  name   = "${var.prefix}-blob-${var.suffix}"
  #account_tier = var.account_tier
  #account_replication_type=var.account_replication_type
  #container_access_type=var.container_access_type
  #blob_type=var.blob_type
  allow_blob_public_access = var.allow_blob_public_access
  blob_source_file         = var.blob_source_file
  tags                     = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}