<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_subnet.private_zone1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_zone2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_zone1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_zone2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | Name of the EKS cluster | `string` | `"demo"` | no |
| <a name="input_env"></a> [env](#input\_env) | Infrastructure environment | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |
| <a name="input_zone1"></a> [zone1](#input\_zone1) | First availability zone | `string` | `"eu-central-1a"` | no |
| <a name="input_zone2"></a> [zone2](#input\_zone2) | Second availability zone | `string` | `"eu-central-1b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_name"></a> [eks\_name](#output\_eks\_name) | Name of the EKS cluster |
| <a name="output_subnet_private1_id"></a> [subnet\_private1\_id](#output\_subnet\_private1\_id) | ID of the first private zone |
| <a name="output_subnet_private2_id"></a> [subnet\_private2\_id](#output\_subnet\_private2\_id) | ID of the second private zone |
| <a name="output_subnet_public1_id"></a> [subnet\_public1\_id](#output\_subnet\_public1\_id) | ID of the first public zone |
| <a name="output_subnet_public2_id"></a> [subnet\_public2\_id](#output\_subnet\_public2\_id) | ID of the second public zone |
<!-- END_TF_DOCS -->