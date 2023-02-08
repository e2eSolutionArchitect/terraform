resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}-storage-acc-${var.suffix}"
  resource_group_name      = module.azure_rg.name # azurerm_resource_group.example.name
  location                 = module.azure_rg.location
  account_tier             = var.account_tier             #"Standard"
  account_replication_type = var.account_replication_type #"LRS"
  allow_blob_public_access = var.allow_blob_public_access
  tags = merge(
    { "resourcename" = "${var.name}-storage-acc" }, var.tags
  )
}

resource "azurerm_storage_container" "this" {
  name                  = "${var.prefix}-storage-container-${var.suffix}"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = var.container_access_type #"private"
  tags = merge(
    { "resourcename" = "${var.name}-storage-container" }, var.tags
  )
}

resource "azurerm_storage_blob" "this" {
  name                   = var.name #"${var.prefix}-storage-blob-${var.suffix}" #"my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = var.blob_type        #"Block"
  source                 = var.blob_source_file #"some-local-file.zip"
  tags = merge(
    { "resourcename" = "${var.name}-storage-blob" }, var.tags
  )
}