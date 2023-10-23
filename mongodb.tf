resource "mongodbatlas_cluster" "db" {
  project_id = var.mongodbatlas_project_id
  name       = var.name

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = var.mongodbatlas_region
  provider_instance_size_name = "M0"
}

locals {
  database_connection = split(":", replace(split(",", mongodbatlas_cluster.db.connection_strings.0.standard).0, "mongodb://", ""))
  url                 = local.database_connection.0
  port                = local.database_connection.1
}