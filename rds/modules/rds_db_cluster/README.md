# RDS

- [rds_db_cluster](#rds_db_cluster)

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
| cluster_identifier       | object       | ✔        | The name of the RDS instance |
| engine | string       | ✔        | The database engine to use                                  |
| engine_version | string      | ✔      | The engine version to use  |
| db_cluster_instance_class                | string  | ✔        | The instance type of the RDS instance      |
| db_cluster_parameter_group_name                | string  | ✔        | Name of the DB parameter group to associate      |
| database_name       | string       | ✔        | The DB name to create. If omitted, no database is created initially |
| master_username                | string  | ✔        | Username for the master DB user      |
| master_password       | string       | ✔        | Password for the master DB user. |
| db_subnet_group_name       | string       | ✔        | Name of DB subnet group |
| vpc_security_group_ids       | list(string)       | ✔        | List of VPC security groups to associate |
| backup_retention_period       | number       | ✔        | The days to retain backups for |
| skip_final_snapshot       | bool       | ✔        | If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted |
| preferred_backup_window       | string       | ✔        | This setting allows you to specify a specific time range when the system will automatically create backup copies of your database for data protection and disaster recovery. |
| availability_zones       | string       | ✔        | The Availability Zone of the RDS instance |
| copy_tags_to_snapshot       | string       | ✔        | On delete, copy all Instance tags to the final snapshot |
| preferred_maintenance_window       | string       | ✔        | The window to perform maintenance in (Eg: 'Mon:00:00-Mon:03:00'") |
