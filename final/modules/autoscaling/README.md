## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.48.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_networking"></a> [networking](#module\_networking) | ../networking | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for the autoscaling instances | `string` | `"ami-07caf09b362be10b8"` | no |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | CIDR block for the private subnet | `string` | `"10.0.1.0/24"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | `"my-project"` | no |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR block for the public subnet | `string` | `"10.0.0.0/24"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | The ID of the autoscaling group. |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The name of the autoscaling group. |
| <a name="output_autoscaling_security_group_id"></a> [autoscaling\_security\_group\_id](#output\_autoscaling\_security\_group\_id) | The ID of the security group associated with the autoscaling group. |
| <a name="output_launch_configuration_id"></a> [launch\_configuration\_id](#output\_launch\_configuration\_id) | The ID of the launch configuration used by the autoscaling group. |
| <a name="output_launch_configuration_name"></a> [launch\_configuration\_name](#output\_launch\_configuration\_name) | The name of the launch configuration used by the autoscaling group. |
