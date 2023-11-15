# 6.CloudWatch

- [cloudwatch](#cloudwatch)
  - [log_group_module](#log_group_module)
  - [ecs_autoscaling_alarm_module](#ecs_autoscaling_alarm_module)

---

## cloudwatch

## log_group_module

support tạo cloudwatch log groups

### INPUT

| Hạng mục               | kiểu dữ liệu | bắt buộc | memo                                                                                                 |
| ---------------------- | ------------ | -------- | ---------------------------------------------------------------------------------------------------- |
| log-groups-config-data | list(object) | ✔        | `name` : tên của log group </br>`retention_in_days` : thời gian tồn tại của log (`0` : không có hạn) |

format sample:

```sh
variable "log-groups-config-data" {
  type = list(object({
    name              = string
    retention_in_days = optional(number, 0)
  }))

  default = [
    {
      name              = "/aws/ecs/containerinsights/CLST-SD-NDEV2-FRW/performance"
      retention_in_days = 400
    },
    {
      name              = "/aws/events/CWL-SVC-SD-NDEV2-FRW/serviceevents"
      retention_in_days = 400
    }
  ]
```

### OUTPUT

| Hạng mục        | kiểu dữ liệu | memo                       |
| --------------- | ------------ | -------------------------- |
| log-groups-info | map          | thông tin log group đã tạo |

---

## ecs_autoscaling_alarm_module

support metric alarm cho việc autoscaling : `SCALE-IN` , `SCALE-OUT` task cho ECS

- `SCALE-IN` => memory, cpu thiếu => `SCALE-IN` : remove bớt task
  `SCALE-OUT` : ngược lại

※tài liệu tham khảo :

- [comparison_operator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#comparison_operator)
- [aws-services-cloudwatch-metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html)

### INPUT

| Hạng mục                      | kiểu dữ liệu | bắt buộc | memo                          |
| ----------------------------- | ------------ | -------- | ----------------------------- |
| scale-target                  | object       | ✔        | thông tin đối tượng add alarm |
| ecs-metric-alarms-config-data | list(object) | ✔        | cấu hình alarm                |

format sample: **scale-target**

```sh
{
    cluster-name = "bluegreen-cluster"
    service-name = "bluegreen-service"
    min-capacity = 1
    max-capacity = 5
  }
```

format sample: **ecs-metric-alarms-config-data**

```sh
[
    {
      alarm-name = "ALM-SD-NDEV2-FRW-APP-CPU-SCALEIN"
      alarm-config = {
        metric-name         = "CPUUtilization"
        comparison-operator = "LessThanThreshold"
        statistic           = "Average"
        threshold           = 40
        alarm-actions       = "SCALE-UP"
      }
    },
    {
      alarm-name = "ALM-SD-NDEV2-FRW-APP-CPU-SCALEOUT"
      alarm-config = {
        metric-name         = "CPUUtilization"
        comparison-operator = "GreaterThanOrEqualToThreshold"
        statistic           = "Average"
        threshold           = 70
        alarm-actions       = "SCALE-DOWN"
      }
    }
  ]
```

### OUTPUT

| Hạng mục | kiểu dữ liệu | memo |
| -------- | ------------ | ---- |
| -        | -            | -    |

---
