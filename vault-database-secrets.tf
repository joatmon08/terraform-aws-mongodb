resource "vault_mount" "db" {
  path = "${var.business_unit}/database"
  type = "database"
}

resource "vault_database_secret_backend_connection" "db" {
  backend       = vault_mount.db.path
  name          = var.name
  allowed_roles = [var.name]

  mongodbatlas {
    public_key  = data.vault_generic_secret.mongodbatlas.data["public_key"]
    private_key = data.vault_generic_secret.mongodbatlas.data["private_key"]
    project_id  = var.mongodbatlas_project_id
  }
}

resource "vault_database_secret_backend_role" "db" {
  backend             = vault_mount.db.path
  name                = var.name
  db_name             = vault_database_secret_backend_connection.db.name
  creation_statements = ["{\"database_name\" : \"admin\", \"roles\" : [{ \"databaseName\" : \"admin\", \"roleName\" : \"readWriteAnyDatabase\" }] }"]
  default_ttl         = 3600
  max_ttl             = 7200
}