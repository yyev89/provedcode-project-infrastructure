<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.16.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | ./modules/application | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_gateways"></a> [gateways](#module\_gateways) | ./modules/gateways | n/a |
| <a name="module_lbc"></a> [lbc](#module\_lbc) | ./modules/lbc | n/a |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ./modules/monitoring | n/a |
| <a name="module_nodegroup"></a> [nodegroup](#module\_nodegroup) | ./modules/nodegroup | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a |
| <a name="module_routes"></a> [routes](#module\_routes) | ./modules/routes | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |
| <a name="module_subnets"></a> [subnets](#module\_subnets) | ./modules/subnets | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Datadog API Key | `string` | n/a | yes |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | Datadog Application Key | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | RDS root password | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy infrastructure | `string` | `"eu-central-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_db_name"></a> [db\_instance\_db\_name](#output\_db\_instance\_db\_name) | RDS database name |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | RDS instance endpoint |
| <a name="output_db_instance_password"></a> [db\_instance\_password](#output\_db\_instance\_password) | RDS password |
| <a name="output_db_instance_username"></a> [db\_instance\_username](#output\_db\_instance\_username) | RDS username |
| <a name="output_env"></a> [env](#output\_env) | Infrastructure environment |
| <a name="output_iam_access_key_id"></a> [iam\_access\_key\_id](#output\_iam\_access\_key\_id) | S3 access key |
| <a name="output_iam_access_key_secret"></a> [iam\_access\_key\_secret](#output\_iam\_access\_key\_secret) | S3 secret key |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | Amazon S3 bucket name for user photos |
| <a name="output_s3_bucket_region"></a> [s3\_bucket\_region](#output\_s3\_bucket\_region) | S3 region |
<!-- END_TF_DOCS -->