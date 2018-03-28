# api-gateway-webapp-tf

**Info**
------
This Terraform module creates a range of resources to deliver a functional API Gateway configuration for simple Web Applications.

**Story**
------
[API Gateway for simple WebApps with Lambda-based (BA) custom authorizer](https://medium.com/@sebolabs/apig-lambda-custom-basic-auth-4f891f463b98)

**Usage**
------
```python
module "webapp-api" {
  source = "github.com:sebolabs/api-gateway-webapp-tf.git"

  # GENERAL
  project     = "lab"
  environment = "test"
  component   = "svc"
  name        = "webapp"

  # DNS
  public_domain_name = "test.lab.aws"
  certificate_arn    = "<certificate ARN>"
  dns_alias          = "webapp"

  # API GATEWAY
  assets_s3_bucket_name              = "my-bucket"
  assets_s3_bucket_path              = "assets"
  integration_uri                    = "${module.lambda_webapp.invoke_arn}"
  exec_logs_enabled                  = true
  exec_logs_cwlg_retention_in_days   = 3
  exec_logs_logging_level            = "INFO"
  exec_logs_metrics_enabled          = false
  exec_logs_data_trace_enabled       = false
  access_logs_enabled                = true
  access_logs_cwlg_retention_in_days = 7

  # AUTHORIZER
  basic_auth_enabled                = true
  authorizer_timeout                = 5
  authorizer_memory_size            = 128
  authorizer_cwlg_retention_in_days = 3
  authorizer_env_vars               = {
    USERNAME = "user"
    PASSWORD = "pass"
  }
}
```

**Terraform compatibility**
------
TF versions tested: 0.11.2

**Dependencies**
------
1. lambda-file-tf
