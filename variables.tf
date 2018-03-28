variable "project" {
  type        = "string"
  description = "The project name"
}

variable "environment" {
  type        = "string"
  description = "The environment name"
}

variable "component" {
  type        = "string"
  description = "The component name"
}

variable "name" {
  type        = "string"
  description = "The API Gateway name"
}

variable "module" {
  type        = "string"
  description = "The module name"
  default     = "api-gateway-webapp"
}

variable "default_tags" {
  type        = "map"
  description = "Default tags to be applied to all taggable resources"
  default     = {}
}

variable "integration_uri" {
  type        = "string"
  description = "The API Gateway integration URI (Lambda Invoke ARN)"
}

variable "stage_name" {
  type        = "string"
  description = "The name of the stage"
  default     = ""
}

variable "dns_alias" {
  type        = "string"
  description = "The name of the alias record to be used for the API Gateway custom domain name"
}

variable "custom_env_alias_prefix" {
  type        = "string"
  description = "A prefix appended to -<environment> for custom domain name used only when no dns_alias defined"
  default     = "app"
}

variable "public_domain_name" {
  type        = "string"
  description = "The domain name to be used for the API Gateway domain name"
  default     = ""
}

variable "certificate_arn" {
  type        = "string"
  description = "The ACM certificate arn"
}

variable "assets_s3_bucket_name" {
  type        = "string"
  description = "The S3 Bucket name where static assets are stored"
}

variable "assets_s3_bucket_path" {
  type        = "string"
  description = "The S3 Bucket path where static assets are stored"
}

variable "exec_logs_enabled" {
  type        = "string"
  description = "Whether API Gateway execution logs should be enabled"
}

variable "exec_logs_cwlg_retention_in_days" {
  type        = "string"
  description = "Specifies the number of days you want to retain log events for the API Gateway Exec log group"
}

variable "exec_logs_logging_level" {
  type        = "string"
  description = "Specifies the logging level for this method, which effects the log entries pushed to Amazon CloudWatch Logs"
}

variable "exec_logs_data_trace_enabled" {
  type        = "string"
  description = "Specifies whether data trace logging is enabled for this method, which effects the log entries pushed to Amazon CloudWatch Logs"
}

variable "exec_logs_metrics_enabled" {
  type        = "string"
  description = "Specifies whether Amazon CloudWatch metrics are enabled for this method"
}

variable "access_logs_enabled" {
  type        = "string"
  description = "Whether API Gateway access logs should be enabled"
}

variable "access_logs_cwlg_retention_in_days" {
  type        = "string"
  description = "Specifies the number of days you want to retain log events for the API Gateway Access log group"
}

variable "basic_auth_enabled" {
  type        = "string"
  description = "Whether Custom BA authrizer should be enabled for all methods"
  default     = false
}

variable "authorizer_memory_size" {
  type        = "string"
  description = "Amount of memory in MB your Lambda Function can use at runtime"
}

variable "authorizer_timeout" {
  type        = "string"
  description = "The amount of time your Lambda Function has to run in seconds"
}

variable "authorizer_publish" {
  type        = "string"
  description = "Whether to publish creation/change as new Lambda Function Version"
}

variable "authorizer_cwlg_retention_in_days" {
  type        = "string"
  description = "Specifies the number of days you want to retain log events in the specified log group"
}

variable "authorizer_env_vars" {
  type        = "map"
  description = "The Lambda environment's variables map"
  default     = {}
}
