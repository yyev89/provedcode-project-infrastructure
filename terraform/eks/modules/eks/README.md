<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | EKS cluster kubernetes version | `string` | `"1.30"` | no |
| <a name="input_env"></a> [env](#input\_env) | Infrastructure environment | `string` | n/a | yes |
| <a name="input_subnet_private1_id"></a> [subnet\_private1\_id](#input\_subnet\_private1\_id) | ID of the first private zone | `string` | n/a | yes |
| <a name="input_subnet_private2_id"></a> [subnet\_private2\_id](#input\_subnet\_private2\_id) | ID of the second private zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_auth_token"></a> [eks\_cluster\_auth\_token](#output\_eks\_cluster\_auth\_token) | EKS cluster auth token |
| <a name="output_eks_cluster_ca_certificate"></a> [eks\_cluster\_ca\_certificate](#output\_eks\_cluster\_ca\_certificate) | EKS cluster CA certificate |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | EKS cluster endpoint |
| <a name="output_eks_name"></a> [eks\_name](#output\_eks\_name) | Name of the EKS cluster |
| <a name="output_eks_version"></a> [eks\_version](#output\_eks\_version) | EKS cluster kubernetes version |
<!-- END_TF_DOCS -->