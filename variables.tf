variable "boundary_address" {
  type        = string
  description = "Boundary address"
}

variable "boundary_username" {
  type        = string
  description = "Boundary address"
}

variable "boundary_password" {
  type        = string
  description = "Boundary password"
  sensitive   = true
}

variable "boundary_scope_id" {
  type        = string
  description = "Boundary scope ID for setting up target to database"
}

variable "boundary_credentials_store_id" {
  type        = string
  description = "Boundary credentials store ID"
}

variable "consul_address" {
  type        = string
  description = "Consul address"
}

variable "consul_token" {
  type        = string
  description = "Consul token"
  sensitive   = true
}

variable "consul_datacenter" {
  type        = string
  description = "Consul datacenter"
  default     = null
}

variable "vault_address" {
  type        = string
  description = "Vault address"
}

variable "vault_token" {
  type        = string
  description = "Vault token"
  sensitive   = true
}

variable "vault_namespace" {
  type        = string
  description = "Vault namespace"
}

variable "mongodbatlas_project_id" {
  type        = string
  description = "Project ID for MongoDB Atlas"
}

variable "name" {
  type        = string
  description = "Name of cluster"
}

variable "business_unit" {
  type        = string
  description = "Business unit to create MongoDB Atlas project"
}

variable "org_name" {
  type        = string
  description = "Organization to search for VPC resources, including database subnet group"
}

variable "mongodbatlas_region" {
  type        = string
  description = "MongoDB Atlas provider region, specifically AWS"
}

variable "vault_kubernetes_auth_path" {
  type        = string
  description = "Vault Kubernetes auth path"
  default     = "kubernetes"
}

variable "vault_mongodbatlas_secrets_path" {
  type        = string
  description = "Vault MongoDB Atlas secrets engine path"
  default     = "mongodbatlas"
}

variable "additional_service_account_names" {
  type        = list(string)
  description = "Additional service account names to allow access to database credentials"
  default     = []
}
