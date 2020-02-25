**Usage**
```go
module "iam-policy" {
    source = "https://gitlab.com/centrias/terraform-modules/terraform-aws-security.git/iam-policy"
    minimum_password_length        = 20
    require_lowercase_characters   = true
    require_numbers                = true
    require_uppercase_characters   = true
    require_symbols                = true
    allow_users_to_change_password = true
}
```


|Variable|Type|Default|
|--------|-----|-----------|
|minimum_password_length|Number|20|
|require_lowercase_characters|Boolean|true|
|require_numbers|Boolean|true|
|require_uppercase_characters|Boolean|true|
|require_symbols|Boolean|true|
|allow_users_to_change_password|Boolean|true|