resource "boundary_host_catalog_static" "database" {
  name        = "${var.business_unit}-database"
  description = "${var.business_unit} database"
  scope_id    = var.boundary_scope_id
}

resource "boundary_host_static" "database" {
  type            = "static"
  name            = "${var.business_unit}-database"
  description     = "${var.business_unit} database"
  address         = local.url
  host_catalog_id = boundary_host_catalog_static.database.id
}

resource "boundary_host_set_static" "database" {
  type            = "static"
  name            = "${var.business_unit}-database"
  description     = "Host set for ${var.business_unit} database"
  host_catalog_id = boundary_host_catalog_static.database.id
  host_ids        = [boundary_host_static.database.id]
}

resource "boundary_target" "database" {
  type                     = "tcp"
  name                     = "database"
  description              = "${var.business_unit} Database Target"
  scope_id                 = var.boundary_scope_id
  ingress_worker_filter    = "\"database\" in \"/tags/type\""
  egress_worker_filter     = "\"${var.org_name}\" in \"/tags/type\""
  session_connection_limit = -1
  default_port             = local.port
  host_source_ids = [
    boundary_host_set_static.database.id
  ]
  brokered_credential_source_ids = [
    boundary_credential_library_vault.database.id
  ]
}

resource "boundary_credential_library_vault" "database" {
  name                = "database-${var.business_unit}"
  description         = "App credential library for ${var.business_unit} databases"
  credential_store_id = var.boundary_credentials_store_id
  path                = "${vault_mount.db.path}/creds/${vault_database_secret_backend_role.db.name}"
  http_method         = "GET"
}