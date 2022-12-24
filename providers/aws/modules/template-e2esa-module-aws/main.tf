
resource "name" "this" {
  name = "${var.name}-name"
  tags = merge(
    { "resourcename" = "${var.name}-name" }, var.tags
  )
}