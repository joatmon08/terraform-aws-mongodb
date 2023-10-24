resource "vault_mount" "static" {
  path        = "${var.business_unit}/static"
  type        = "kv"
  options     = { version = "2" }
  description = "For static secrets related to ${var.business_unit}"
}

resource "vault_kv_secret_v2" "mongodb" {
  mount               = vault_mount.static.path
  name                = "mongodb"
  delete_all_versions = true

  data_json = <<EOT
{
  "connection_string": "${replace(mongodbatlas_cluster.db.connection_strings.0.standard, "mongodb://", "")}"
}
EOT
}