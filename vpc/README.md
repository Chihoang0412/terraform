# 1.VPC

- [vpc_module](#vpc_module)

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
  3. Thiết định input variables cho module vpc
```
```sh
  4. Thực hiện apply source (khởi tạo VPC)
    - terraform apply
```


## Thiết định variables (INPUT)
| Hạng mục            | kiểu dữ liệu | bắt buộc | memo                                            |
| ------------------- | ------------ | -------- | ----------------------------------------------- |
| vpc       | object       | ✔        | config name, cidr_block... |
| subnets | list(map(string))       | ✔        | list subnet cần tạo                                  |
| igw | string      | ✔      | config internet_gateway  |
| eips                | list(string)  | ✔        | config EIP      |
| natgw                | list(map(string))  | ✔        | config nat_gateway      |
| route_tables       | list(map(string))       | ✔        | route table |
| route_table_associations                | list(map(string))  | ✔        | route table assoctions      |
| create_route_internet_gateway       | bool       | ✔        | flag xác định có khởi tạo internet gateway không, có tạo route tới igw hay không |
| create_route_nat_gateway       | bool       | ✔        | flag xác định có khởi tạo nat gateway không, có tạo route tới nat hay không |
| routes_igw       | list(map(string))       | ✔        | list route tới IGW |
| routes_ngw       | list(map(string))       | ✔        | list route tới NAT |
| security_groups       | list(object())       | ✔        | thiết định security groups |
| create_ingress_rules       | bool       | ✔        | flag xác định có tạo inbound rules cho security groups không |
| create_egress_rules       | bool       | ✔        | flag xác định có tạo outbound rules cho security groups không |


## Một số cấu trúc biến phức tạp
```sh
  variable "subnets" {
  description = "Public subnets"
  type        = list(map(string))
  default = [
    {
      name       = "SN-SD-DEMO-PRIVATE0-VA-1a"
      cidr_block = "192.170.201.0/24"
      az         = "ap-northeast-1a",
    },
    {
      name       = "SN-SD-DEMO-PRIVATE0-VA-1c"
      cidr_block = "192.170.203.0/24"
      az         = "ap-northeast-1c",
    }
  ]
}
name: Tên của subnet (bắt buộc)
cidr_block: cidr_block tương ứng (bắt buộc)
az: Tùy chọn
```

```sh
  variable "route_table_associations" {
  description = "Route table assoctions"
  type        = list(map(string))
  default = [
    {
      route_table_name = "RT-SD-DEMO-PRIVATE0-VA"
      subnet_name      = "SN-SD-DEMO-PRIVATE0-VA-1a"
    },
    {
      route_table_name = "RT-SD-DEMO-PRIVATE1-VA"
      subnet_name      = "SN-SD-DEMO-PRIVATE0-VA-1c"
    }
  ]
}

route_table_name: Tên của route_table
subnet_name: Tên của subnet được association vào route_table_name tương ưungs
```

```sh
variable "routes_igw" {
  description = "List route"
  type        = list(map(string))
  default = [
    {
      route_table : "RT-SD-DEMO-FRONT0-VA"
      destination_cidr_block : "0.0.0.0/0"
      internet_gateway : "IGW-SD-DEMO-VA"
    },
    {
      route_table : "RT-SD-DEMO-MNG0-VA"
      destination_cidr_block : "0.0.0.0/0"
      internet_gateway : "IGW-SD-DEMO-VA"
    }
  ]
}
route_table: Tên của route_table cần thiết định route tới Internet gateway
destination_cidr_block: destination
internet_gateway: Tên của Internet gateway
```

```sh
variable "security_groups" {
  description = "Security groups"
  type = list(object({
    name        = string
    description = string
    ingress_rules = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))

  default = [
    {
      name        = "SG-SD-DEMO-FRW-ALB-E"
      description = "Allow TLS inbound traffic"
      ingress_rules = [
        {
          description = "LVN"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["118.70.128.3/32"]
        },
        {
          description = "TLS from VPC"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["113.190.233.137/32"]
        }
      ]

    }
  ]

}
ingress_rules: Thiết định cho inboud rules
    {
        name: Tên của security group
        from_port, to_port: config port tương ứng cho security group
        protocol: protocol
        cidr_blocks: Thiết định cidr_block
    }

egress_rules: Thiết định cho outbound rules
    {
        name: Tên của security group
        from_port, to_port: config port tương ứng cho security group
        protocol: protocol
        cidr_blocks: Thiết định cidr_block
    }

Lưu ý rằng nếu muốn thiết định outbound cho security_group thì thêm đoạn code sau vào resource "aws_security_group":

  dynamic "egress" {
    for_each = var.security_groups[count.index].egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
```