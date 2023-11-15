# 18.SNS

- [aws_sns_topic](#aws_sns_topic)
  - [topic_subscriptions_module](#topic_subscriptions_module)

---

## main

xử lý chính : từ thiết định config biến truyền vào , support :

- tạo topic
  - default tạo default policy (thông tin config giống với tạo trên aws console)
    ※trường hợp không muốn tạo mặc định, set `add-default-policy` = `false`
  - tạo custom policy theo list policies truyền
- tạo Subscriptions cho topic (※ hiện chỉ mới test với `email`)

**※ Input sample**

```sh
[
    {
      name = "SNT-SD-NDEV2-VA-EMAIL"
      policies = {
        add-default-policy = true
        custom-policies = [
          {
            actions = ["sns:Publish"]
            effect  = "Allow"
            principals = {
              identifiers = ["events.amazonaws.com"]
              type        = "Service"
            }
            sid = "my-policy-1"
          }
        ]
      }
      subscriptions = [
        {
          end-point = "tranvinhthinh@luvina.net"
          protocol  = "email"
        },
        {
          end-point = "nguyencanhhoang@luvina.net"
          protocol  = "email"
        },
      ]
    },
    {
      name = "SNT-SD-NDEV2-VA-SecurityGroupCheckByConfig"
      policies = {
        add-default-policy = true
        custom-policies    = []
      }
      subscriptions = [
        {
          end-point = "tranvankhoi@luvina.net"
          protocol  = "email"
        },
      ]
    }
  ]
```

---

## aws_sns_topic

### INPUT

| Hạng mục          | kiểu dữ liệu | bắt buộc | memo                                                                                                                   |
| ----------------- | ------------ | -------- | ---------------------------------------------------------------------------------------------------------------------- |
| topic-config-data | object       | ✔        | `name` : topic name </br>`policies` : thông tin config policies </br> `subscriptions` : config thông tin subscriptions |

※ tham chiếu input sample

### OUTPUT

| Hạng mục | kiểu dữ liệu | memo |
| -------- | ------------ | ---- |
| -        | -            | -    |

---

## topic_subscriptions_module

support tạo subscriptions cho topic

### INPUT

| Hạng mục  | kiểu dữ liệu | bắt buộc | memo                          |
| --------- | ------------ | -------- | ----------------------------- |
| topic-arn | string       | ✔        |  |
| subscriptions | list(string)       | ✔        |  |


### OUTPUT

| Hạng mục | kiểu dữ liệu | memo |
| -------- | ------------ | ---- |
| -        | -            | -    |

---
