resource "azurerm_storage_container" "this" {
  name                  = "${var.prefix}-container-${var.suffix}"
  storage_account_name  = var.storage_account_name  #azurerm_storage_account.this.name
  container_access_type = var.container_access_type #"private"
  tags = merge(
    { "resourcename" = "${var.name}-container" }, var.tags
  )
}