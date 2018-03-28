resource "aws_api_gateway_rest_api" "main" {
  name = "${format(
    "%s-%s-%s-%s",
    var.project,
    var.environment,
    var.component,
    var.name
  )}"

  binary_media_types = ["*/*"]

  description = "API Gateway for ${upper(var.project)} ${upper(var.component)} ${upper(var.name)} ${upper(var.environment)} environment"
}
