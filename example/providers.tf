terraform {
  required_version = "~> 1.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.20"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.12"
    }
  }
}