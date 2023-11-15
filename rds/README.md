# RDS

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
    - terraform apply -var-file="secrets.tfvars"
```


## Thiết định variables (INPUT)
| Hạng mục            | kiểu dữ liệu | bắt buộc | memo                                            |
| ------------------- | ------------ | -------- | ----------------------------------------------- |
| aws_region       | object       | ✔        | config region |
| settings | map(any)       | ✔        | thông tin cơ bản của rds:engine, engine version, db_name,....                                  |
| db_username | string      | ✔      | user name (chỉ cần khai báo thông tin lưu trong file secrets.tfvars)  |
| db_password                | string  | ✔        | password (chỉ cần khai báo thông tin lưu trong file secrets.tfvars)      |
| vpc_cidr                | string  | ✔        | CIDR for creating the VPC      |
| subnet_count       | number       | ✔        | Number of subnets. |
| subnet_cidr                | list(string)  | ✔        | Available cidr blocks for subnets.      |
| availability_zone       | list(string)       | ✔        | Availability Zone chỉ định muốn tạo |
| subnet_name       | list(string)       | ✔        | List subnet name blocks for subnets. |
