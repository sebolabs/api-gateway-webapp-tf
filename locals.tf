locals {
  domain_name = "${var.dns_alias != "" ?
    "${var.dns_alias}.${var.public_domain_name}" :
    "${var.custom_env_alias_prefix}-${var.environment}.${var.public_domain_name}"}"

  authorization = "${var.basic_auth_enabled ? "CUSTOM" : "NONE"}"
  authorizer_id = "${var.basic_auth_enabled ? aws_api_gateway_authorizer.basic.id : ""}"

  # Files below influence APIG configuration and therfore whenever they change
  # a new deployment is triggered due to stage_description value change.
  stage_description = "${md5(
    format(
      "%s%s%s%s%s%s",
      file("${path.module}/api_gateway_authorizer.tf"),
      file("${path.module}/api_gateway_deployment.tf"),
      file("${path.module}/api_gateway_method_settings.tf"),
      file("${path.module}/api_gateway_rest_api.tf"),
      file("${path.module}/resource-assets.tf"),
      file("${path.module}/resource-proxy.tf"),
      file("${path.module}/resource-root.tf"),
    )
  )}"

  tags = {
    Module = "${var.module}"
  }
}
