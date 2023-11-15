# 1.IAM

- [policy_module](#policy_module)
- [role_module](#role_module)
- [user_group_module](#user_group_module)

※ how to run

```sh
# update vị trí lưu state nếu cần : ./iam/versions.tf
  backend "s3" {
    bucket = "895748805273-sd-terraform-states-iam"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
```

```sh
# tu thu muc IAM
terraform plan -var-file=./env-config/dev.tfvars -out=dev.tfplan && terraform apply -input=false dev.tfplan
terraform plan -destroy -var-file=./env-config/dev.tfvars -out=dev.tfplan && terraform apply -destroy -input=false dev.tfplan
```

---

## policy_module

support tạo policies từ file :scroll:`.json`

### INPUT

| Hạng mục            | kiểu dữ liệu | bắt buộc | memo                                            |
| ------------------- | ------------ | -------- | ----------------------------------------------- |
| config-folder       | string       | ✔        | :file_folder: chứa file(:scroll:`.json`) config |
| polices_name_prefix | string       | -        | default : `""`                                  |
| polices_create_flag | boolean      | -        | default : `false`                               |
| tags                | map          | ✔        |                                                 |

### OUTPUT

| Hạng mục    | kiểu dữ liệu | memo                         |
| ----------- | ------------ | ---------------------------- |
| policy-arns | list         | list ARN của policy được tạo |

---

## role_module

**support tạo:**

- Roles
- Roles policies

**※ cấu trúc :file_folder: config**

- :file_folder:`role-config` ※config root folder
  - :scroll:`{RoleName}`.json
  - :file_folder:`{RoleName}` : folder chứa file policies `.json`
    - :scroll:`{policyName}`.json

**sample :scroll:`{RoleName}`.json**

```json
{
  "role-name": "RL-SD-NDEV2-BTS-BAT",
  "instance-profile-name": "IPF-SD-NDEV2-BTS-BAT",
  "aws-managed-policies": [
    "AmazonEC2ContainerRegistryFullAccess",
    "AmazonS3FullAccess",
    "ReadOnlyAccess",
    "AmazonECS_FullAccess"
  ],
  "my-policies-create-flg": true,
  "trust-relationships": {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
}
```

**sample :scroll:`{policyName}`.json**
theo định dạng của AWS

### INPUT

| Hạng mục                | kiểu dữ liệu | bắt buộc | memo                                                      |
| ----------------------- | ------------ | -------- | --------------------------------------------------------- |
| role-name               | string       | ✔        |                                                           |
| roles-config-root-foler | string       | ✔        | folder chứa file(:scroll:`.json`) config policy của group |
| tags                    | map          | ✔        |                                                           |

### OUTPUT

| Hạng mục | kiểu dữ liệu | memo |
| -------- | ------------ | ---- |
| -        | -            | -    |

---

## user_group_module

**support tạo:**

- user group
- user group policies

**※ cấu trúc :file_folder: config**

- :file_folder:`group-config` ※config root folder
  - :scroll:`{groupName}`.json
  - :file_folder:`{groupName}` : folder chứa file policies .json
    - :scroll:`{policyName}`.json

**sample :scroll:`{groupName}`.json**

```json
{
  "role-name": "operators",
  "aws-managed-policies": [
    "AmazonRDSFullAccess",
    "IAMFullAccess",
    "AmazonEC2ContainerRegistryFullAccess",
    "AmazonS3FullAccess",
    "CloudWatchFullAccess",
    "AWSBatchFullAccess",
    "AmazonECS_FullAccess",
    "AWSStepFunctionsFullAccess",
    "CloudWatchEventsFullAccess"
  ],
  "my-policies-create-flg": true
}
```

**sample :scroll:`{policyName}`.json**
theo định dạng của AWS

### INPUT

| Hạng mục                | kiểu dữ liệu | bắt buộc | memo                                                      |
| ----------------------- | ------------ | -------- | --------------------------------------------------------- |
| user-group-name         | string       | ✔        |                                                           |
| group-config-root-foler | string       | ✔        | folder chứa file(:scroll:`.json`) config policy của group |
| tags                    | map          | ✔        |                                                           |

### OUTPUT

| Hạng mục | kiểu dữ liệu | memo |
| -------- | ------------ | ---- |
| -        | -            | -    |

---
