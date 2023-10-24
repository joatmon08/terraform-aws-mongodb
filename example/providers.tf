terraform {
  required_version = "~> 1.0"

  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.20"
    }
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.18"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.12"
    }
  }
}