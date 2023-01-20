
module "gc_vm" {
  source = "../../modules/e2esa-module-gc-vm"
  name   = "${var.prefix}-demo-${var.suffix}"
  zone   = var.zone
  image  = var.image
  tags   = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}
