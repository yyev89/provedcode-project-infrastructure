<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The size of allocated storage for database | `number` | `8` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | RDS database name | `string` | `"provedcode"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | RDS root password | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | RDS root user | `string` | `"app_user"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Engine for the database | `string` | `"postgres"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Engine version for the database | `string` | `"16.3"` | no |
| <a name="input_env"></a> [env](#input\_env) | Infrastructure environment | `string` | n/a | yes |
| <a name="input_identifier_prefix"></a> [identifier\_prefix](#input\_identifier\_prefix) | RDS identifier prefix for database | `string` | `"postgres-"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance class for the database compute | `string` | `"db.t3.micro"` | no |
| <a name="input_subnet_private1_id"></a> [subnet\_private1\_id](#input\_subnet\_private1\_id) | ID of the first private zone | `string` | n/a | yes |
| <a name="input_subnet_private2_id"></a> [subnet\_private2\_id](#input\_subnet\_private2\_id) | ID of the second private zone | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC cidr block | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_db_name"></a> [db\_instance\_db\_name](#output\_db\_instance\_db\_name) | RDS database name |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | RDS instance endpoint |
| <a name="output_db_instance_password"></a> [db\_instance\_password](#output\_db\_instance\_password) | RDS password |
| <a name="output_db_instance_username"></a> [db\_instance\_username](#output\_db\_instance\_username) | RDS username |
<!-- END_TF_DOCS -->