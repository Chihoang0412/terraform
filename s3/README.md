# 5.S3

## Structure module
1. Folder policies - <i> chứa các file policy json </i>
2. buckets.tf - <i>resource tạo bucket </i>
3. bucket_life_cycle - <i> resource tạo life cycle cho bucket </i>
4. bucket_policies.tf - <i> resource tạo policy cho bucket </i>
5. bucket_public_access_block.tf - <i> resource tạo ACL (pulic access block) </i>
6. bucket_version.tf - <i> resource tạo version cho bucket </i>
7. bucket_server_access_logging.tf -  <i> resource tạo log request bucket </i>


## Variables:

<h3 style="color: yellow"> variable - buckets </h3>

```sh
[
    {
      bucket                  = "20231030-bucket-terraform-01",
      block_all_public_access = false,
      object_lock             = true,
      tags = {
        name        = "20231030-bucket-terraform-01",
        environment = "DEV"
      }
    },
    {
      bucket                  = "20231030-bucket-terraform-02",
      block_all_public_access = true,
      object_lock             = false,
      tags = {
        name        = "20231030-bucket-terraform-02",
        environment = "DEV"
      }
    }
  ]
```

**※Giải thích:**
- bucket: Tên bucket muốn tạo
- block_all_public_access: Nếu thiết định <span style="color: red"> FALSE </span> thì bucket sẽ turn on ACL cho phép object thuộc bucket được truy cập public, <span style="color: red"> TRUE </span> thì ngược lại
- object_lock: <span style="color: red"> TRUE/FALSE </span> thiết định object lock
- tags: Thiết định tag.
---

<h3 style="color: yellow"> variable - bucket_version </h3>

```sh
["20231030-bucket-terraform-01", "20231030-bucket-terraform-02"]
```

**※Giải thích:**
- Thiết định bucket (bucket_name) cần enable thuộc tính bucket version.
---

<h3 style="color: yellow"> variable - bucket_policies </h3>

```sh
["20231030-bucket-terraform-01", "20231030-bucket-terraform-02"]
```

**※Giải thích:**
- Thiết định policy cho bucket (bucket_name) được thiết định.
<span style="color: red"> IMPORTANT: </span> cần tạo ra file policy.json tương ứng với bucket trong folder <span style="color: yellow"> "s3/modules/policies" </span>, file json có tên giống với bucket_name.

```sh
Bucket_name: 20231030-bucket-terraform-01
s3/modules/policies/20231030-bucket-terraform-01.json
```

<h3 style="color: yellow"> variable - bucket_life_cycle </h3>

```sh
[
    {
      bucket = "20231030-bucket-terraform-01",
      life_cycle = {
        id     = "expire-current-versions"
        status = "Enabled"
        expiration = {
          days = 400
        }
      }

    },
    {
      bucket = "20231030-bucket-terraform-02",
      life_cycle = {
        id     = "expire-current-versions"
        status = "Enabled"
        expiration = {
          days = 300
        }
      }

    }
  ]
```

**※Giải thích:**
- Thiết định life cycle cho bucket được thiết định.
- bucket: Tên bucket muốn thiết định
- id: Thiết định ID, max là 250 ký tự
- status: ["Enabled", "Disabled"]
- days: Thiết định thời gian expiration


<h3 style="color: yellow"> variable - bucket_server_access_log </h3>

```sh
[
  {
    bucket        = "20231030-bucket-terraform-01"
    bucket_target = "train-s3"
  }
]
```

**※Giải thích:**
- bucket: Tên bucket cần ghi log
- bucket_target: Nơi lưu file log, recommend target nên để ở bucket khác với bucket muốn ghi log
---


