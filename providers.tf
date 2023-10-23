terraform {
  required_version = "~> 1.0"

  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = ">= 1.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.20"
    }
    consul = {
      source  = "hashicorp/consul"
      version = ">= 2.18"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = ">= 1.12"
    }
  }
}

## Possible bug with Boundary provider, doesn't pick up BOUNDARY_ADDR
provider "boundary" {
  addr                   = var.boundary_address
  auth_method_login_name = var.boundary_username
  auth_method_password   = var.boundary_password
}

provider "consul" {
  address    = var.consul_address
  token      = var.consul_token
  datacenter = var.consul_datacenter
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