terraform {
  required_version = "~> 1.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.20"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = ">= 1.12"
    }
  }
}

provider "vault" {
  address   = var.vault_address
  token     = var.vault_token
  namespace = var.vault_namespace
}

data "vault_generic_secret" "mongodbatlas" {
  path = "${var.vault_mongodbatlas_secrets_path}/creds/${var.business_unit}"
}

provider "mongodbatlas" {
  public_key  = data.vault_generic_secret.mongodbatlas.data["public_key"]
  private_key = data.vault_generic_secret.mongodbatlas.data["private_key"]
}