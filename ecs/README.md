# 9.ECS

- [main config](#main)
- [ecs_cluster_module](#ecs_cluster_module)
- [ecs_service_module](#ecs_service_module)

---

## main

cấu trúc variable:

```sh
[
    {
      cluster-name = "CLST-SD-NDEV2-FRW",
      services = [
        {
          service-name            = "SVC-SD-NDEV2-FRW-API",
          desired-count           = 1
          task-definition-arn     = "arn:aws:ecs:ap-northeast-1:895748805273:task-definition/bluegreen-task-definitions:4"
          task-has-run-on-aws-vpc = true
          subnet-ids              = ["subnet-227d5c79", "subnet-5dbb4c15", "subnet-daa658f1"]
          security-group-ids      = ["sg-d401e1aa", ]
        },
        {
          service-name            = "SVC-SD-NDEV2-FRW",
          desired-count           = 1
          task-definition-arn     = "arn:aws:ecs:ap-northeast-1:895748805273:task-definition/bluegreen-task-definitions:3"
          task-has-run-on-aws-vpc = false
          subnet-ids              = []
          security-group-ids      = []
        },
      ]
    },
    {
      cluster-name = "cicd-jenkins-slave-cluster",
      services     = []
    },
  ]
```

**※Lưu ý:**

- `subnet-ids`, `security-group-ids` <span style="color:red">PHẢI ĐƯỢC </span> thiết định nếu `task-has-run-on-aws-vpc = true`
- `task-has-run-on-aws-vpc = true` thì `task-definition-arn` phải được định nghĩa network mode `aws_vpc`

---

## ecs_cluster_module

support tạo config cluster từ cấu hình main truyền vào.

### INPUT

tham khảo cấu hình từ main truyên vào

### OUTPUT

| Hạng mục    | kiểu dữ liệu | memo                         |
| ----------- | ------------ | ---------------------------- |
| clusters-info | map         | `key={cluster-name}`</br> `value={created_cluster_info}` |

---

## ecs_service_module

support tạo list service cho cluster.

### INPUT

tham khảo cấu hình từ main truyên vào

### OUTPUT

| Hạng mục | kiểu dữ liệu | memo |
| -------- | ------------ | ---- |
| -        | -            | -    |

---
