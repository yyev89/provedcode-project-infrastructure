<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_node_group.general](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | EC2 capacity type of nodes (ON\_DEMAND, SPOT etc.) | `string` | `"ON_DEMAND"` | no |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Desired size of EC2 nodes autoscaling group | `number` | `1` | no |
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | EKS cluster kubernetes version | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Infrastructure environment | `string` | n/a | yes |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | EC2 type of node group instances | `list(string)` | <pre>[<br/>  "t3.medium"<br/>]</pre> | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum size of EC2 nodes autoscaling group | `number` | `1` | no |
| <a name="input_max_unavailable"></a> [max\_unavailable](#input\_max\_unavailable) | Maximum size of unavailable EC2 nodes at once | `number` | `1` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum size of EC2 nodes autoscaling group | `number` | `1` | no |
| <a name="input_subnet_private1_id"></a> [subnet\_private1\_id](#input\_subnet\_private1\_id) | ID of the first private zone | `string` | n/a | yes |
| <a name="input_subnet_private2_id"></a> [subnet\_private2\_id](#input\_subnet\_private2\_id) | ID of the second private zone | `string` | n/a | yes |
<!-- END_TF_DOCS -->