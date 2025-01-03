<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.application_argocd_provedcode](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace_v1.provedcode](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_secret_v1.pg_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_instance_db_name"></a> [db\_instance\_db\_name](#input\_db\_instance\_db\_name) | RDS database name | `string` | `"provedcode"` | no |
| <a name="input_db_instance_endpoint"></a> [db\_instance\_endpoint](#input\_db\_instance\_endpoint) | RDS instance endpoint | `string` | `"postgres:5432"` | no |
| <a name="input_db_instance_password"></a> [db\_instance\_password](#input\_db\_instance\_password) | RDS password | `string` | `"app_pass"` | no |
| <a name="input_db_instance_username"></a> [db\_instance\_username](#input\_db\_instance\_username) | RDS username | `string` | `"app_user"` | no |
| <a name="input_env"></a> [env](#input\_env) | Infrastructure environment | `string` | `"prod"` | no |
| <a name="input_iam_access_key_id"></a> [iam\_access\_key\_id](#input\_iam\_access\_key\_id) | S3 access key | `string` | `"access_key"` | no |
| <a name="input_iam_access_key_secret"></a> [iam\_access\_key\_secret](#input\_iam\_access\_key\_secret) | S3 secret key | `string` | `"secret_key"` | no |
| <a name="input_s3_bucket_id"></a> [s3\_bucket\_id](#input\_s3\_bucket\_id) | Amazon S3 bucket name for user photos | `string` | `"provedcode-app-bucket"` | no |
| <a name="input_s3_bucket_region"></a> [s3\_bucket\_region](#input\_s3\_bucket\_region) | S3 region | `string` | `"eu-central-1"` | no |
<!-- END_TF_DOCS -->