data "vault_policy_document" "db" {
  rule {
    path         = "${vault_mount.db.path}/creds/${vault_database_secret_backend_role.db.name}"
    capabilities = ["read"]
    description  = "get database credentials for ${vault_database_secret_backend_role.db.name}"
  }
}

resource "vault_policy" "db" {
  name   = "${var.business_unit}-db-${vault_database_secret_backend_role.db.name}"
  policy = data.vault_policy_document.db.hcl
}

data "vault_policy_document" "mongodb" {
  rule {
    path         = "${vault_mount.static.path}/*"
    capabilities = ["read"]
    description  = "get database configuration for ${vault_database_secret_backend_role.db.name}"
  }
}

resource "vault_policy" "mongodb" {
  name   = "${var.business_unit}-mongodb"
  policy = data.vault_policy_document.mongodb.hcl
}

resource "vault_kubernetes_auth_backend_role" "db" {
  backend                          = var.vault_kubernetes_auth_path
  role_name                        = vault_database_secret_backend_role.db.name
  bound_service_account_names      = concat([var.business_unit], var.additional_service_account_names)
  bound_service_account_namespaces = [var.business_unit]
  token_ttl                        = 3600
  token_policies                   = [vault_policy.db.name, vault_policy.mongodb.name]
}