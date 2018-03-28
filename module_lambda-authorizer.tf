module "lambda_authorizer" {
  # 'count' for module is not supported yet - TF Issue #953 => count = "${var.basic_auth_enabled ? 1 : 0}"

  source = "github.com:sebolabs/lambda-file-tf.git"

  name        = "${var.name}-auth"
  project     = "${var.project}"
  environment = "${var.environment}"
  component   = "${var.component}"

  filename         = "${path.module}/archives/authorizer.zip"
  source_code_hash = "${base64sha256(file("${path.module}/archives/authorizer.zip"))}"

  runtime     = "nodejs6.10"
  handler     = "authorizer.handler"
  memory_size = "${var.authorizer_memory_size}"
  timeout     = "${var.authorizer_timeout}"
  publish     = "${var.authorizer_publish}"

  env_variables = "${merge(
    var.authorizer_env_vars,
    map()
  )}"

  cwlg_retention_in_days = "${var.authorizer_cwlg_retention_in_days}"
  default_tags           = "${var.default_tags}"
}
