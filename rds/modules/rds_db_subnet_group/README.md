# RDS

- [rds_db_subnet_group](#rds_db_subnet_group)

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
| create | bool | ✔ | Whether to create this resource or not? |
| name | string | ✔ | The name of the DB subnet group |
| name_prefix | bool | ✔ | Determines whether to use `name` as is or create a unique name beginning with `name` as the specified prefix |
| description | string | ✔ | The description of the DB subnet group |
| subnet_ids | string | ✔ | A list of VPC subnet IDs |
| tags | map(string) | ✔ | A mapping of tags to assign to the resource |

| Name | Description |
|------|-------------|
| output_db_subnet_group_arn | The ARN of the db subnet group |
| output_db_subnet_group_id | The db subnet group name |
