# RDS

- [rds_vpc](#rds_vpc)

※ How to run

```sh
  1. Thực hiện khởi tạo module:
    - terraform init
```
```sh
  2. Thiết định providers trong file versions.tf:
    provider "aws" {
    # config thuộc tính cần thiết như: region, assume_role
    # config Credentials
    Tham khảo: [aws_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#container-credentials)
    }
```
```sh
  3. Thiết định input variables cho module rds
```
```sh
  4. Thực hiện apply source (khởi tạo RDS)
    - terraform apply
```


## Thiết định variables (INPUT)
| Hạng mục            | kiểu dữ liệu | bắt buộc | memo                                            |
| ------------------- | ------------ | -------- | ----------------------------------------------- |
| vpc_cidr | string | ✔ | CIDR block for the VPC |
| vpc_name | string | ✔ | The name of the DB subnet group |
| subnet_count | number | ✔ | Number of subnets to create |
| subnet_cidr | list(string) | ✔ | List of subnet CIDR blocks |
| availability_zone | ist(string) | ✔ | List of availability zone |
| subnet_name | map(string) | ✔ | List of subnet name |
| security_group_name | string | ✔ | Name for the security group |

## Outputs
| Name | Description |
|------|-------------|
| vpc_id | VPC id |
| subnet_ids | List subnet id |
| db_security_group_id | Security group id |
