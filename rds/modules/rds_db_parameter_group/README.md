# RDS

- [rds_db_parameter_group](#rds_db_parameter_group)

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
| name | string | ✔ | The name of the DB parameter group |
| name_prefix | bool | ✔ | Determines whether to use `name` as is or create a unique name beginning with `name` as the specified prefix |
| description | string | ✔ | The description of the DB parameter group |
| family | string | ✔ | The family of the DB parameter group |
| parameters | list(map(string)) | ✔ | A list of DB parameter maps to apply" |
| tags | map(string) | ✔ | A mapping of tags to assign to the resource |

## Outputs
| Name | Description |
|------|-------------|
| output_db_parameter_group_arn | The ARN of the db parameter group |
| output_db_parameter_group_id | The db parameter group id |
