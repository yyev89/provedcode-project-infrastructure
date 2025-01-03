<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_zone1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_zone2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_zone1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_zone2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Infrastructure environment | `string` | n/a | yes |
| <a name="input_igw_id"></a> [igw\_id](#input\_igw\_id) | ID of the Internet gateway | `string` | n/a | yes |
| <a name="input_nat_id"></a> [nat\_id](#input\_nat\_id) | ID of the NAT gateway | `string` | n/a | yes |
| <a name="input_subnet_private1_id"></a> [subnet\_private1\_id](#input\_subnet\_private1\_id) | ID of the first private zone | `string` | n/a | yes |
| <a name="input_subnet_private2_id"></a> [subnet\_private2\_id](#input\_subnet\_private2\_id) | ID of the second private zone | `string` | n/a | yes |
| <a name="input_subnet_public1_id"></a> [subnet\_public1\_id](#input\_subnet\_public1\_id) | ID of the first public zone | `string` | n/a | yes |
| <a name="input_subnet_public2_id"></a> [subnet\_public2\_id](#input\_subnet\_public2\_id) | ID of the second public zone | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |
<!-- END_TF_DOCS -->