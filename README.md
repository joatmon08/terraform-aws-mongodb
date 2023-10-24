# terraform-aws-mongodb

MongoDB Atlas Database on AWS.

This is intended to be a Terraform module, although you can run a separate example
to demonstrate integrations with MongoDB Atlas.

## Example

### Prerequisite

You'll need to set up infrastructure as per [joatmon08/hashicorp-stack-demoapp](https://github.com/joatmon08/hashicorp-stack-demoapp).

### Run

Log into Vault and retrieve the credentials you'll need for the module
using the following:

```shell
$ vault kv get -format=json terraform-cloud-operator/bookstore/terraform-aws-postgres > example/secrets.json
```

Copy each value into a file called `secrets.auto.tfvars`.

```hcl
mongodbatlas_project_id = ""
mongodbatlas_region     = ""
vault_address           = ""
vault_namespace         = ""
vault_token             = ""
```

Go into the `example/` directory.

```shell
$ cd example
```

Create the MongoDB cluster and configure Vault database secrets engine for it.
The Terraform configuration dynamically retrieves an API key from MongoDB Atlas
and uses it to create a cluster in a project.

```shell
$ terraform apply
```

Next, create the namespaces and secrets needed for the application.
The manifest uses the [Vault Secrets Operator](https://developer.hashicorp.com/vault/tutorials/kubernetes/vault-secrets-operator)
to retrieve the MongoDB connection string stored in Vault and mount it as
an environment variable. The username and password are dynamically
retrieved by [Vault Agent](https://developer.hashicorp.com/vault/docs/platform/k8s/injector).

```shell
$ kubectl apply -f bookstore/secrets.yaml -n bookstore
```

Create the sample application.

```shell
$ kubectl apply -f bookstore/deployment.yaml -n bookstore
```

### Clean Up

Delete all Kubernetes resources.

```shell
$ kubectl delete -f bookstore/ -n bookstore
```

Delete resources.

```shell
$ terraform destroy
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | >= 1.12 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 3.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | 1.12.2 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mongodbatlas_cluster.db](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cluster) | resource |
| [vault_database_secret_backend_connection.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_connection) | resource |
| [vault_database_secret_backend_role.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_role) | resource |
| [vault_kubernetes_auth_backend_role.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_role) | resource |
| [vault_kv_secret_v2.mongodb](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_mount.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_mount.static](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.mongodb](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_generic_secret.mongodbatlas](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_policy_document.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |
| [vault_policy_document.mongodb](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_service_account_names"></a> [additional\_service\_account\_names](#input\_additional\_service\_account\_names) | Additional service account names to allow access to database credentials | `list(string)` | `[]` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | Business unit to create MongoDB Atlas project | `string` | n/a | yes |
| <a name="input_mongodbatlas_project_id"></a> [mongodbatlas\_project\_id](#input\_mongodbatlas\_project\_id) | Project ID for MongoDB Atlas | `string` | n/a | yes |
| <a name="input_mongodbatlas_region"></a> [mongodbatlas\_region](#input\_mongodbatlas\_region) | MongoDB Atlas provider region, specifically AWS | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of cluster | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Organization to search for VPC resources, including database subnet group | `string` | n/a | yes |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | Vault address | `string` | n/a | yes |
| <a name="input_vault_kubernetes_auth_path"></a> [vault\_kubernetes\_auth\_path](#input\_vault\_kubernetes\_auth\_path) | Vault Kubernetes auth path | `string` | `"kubernetes"` | no |
| <a name="input_vault_mongodbatlas_secrets_path"></a> [vault\_mongodbatlas\_secrets\_path](#input\_vault\_mongodbatlas\_secrets\_path) | Vault MongoDB Atlas secrets engine path | `string` | `"mongodbatlas"` | no |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | Vault namespace | `string` | n/a | yes |
| <a name="input_vault_token"></a> [vault\_token](#input\_vault\_token) | Vault token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host"></a> [host](#output\_host) | MongoDB Atlas SRV hostname |
