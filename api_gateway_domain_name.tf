resource "aws_api_gateway_domain_name" "main" {
  count           = "${var.public_domain_name != "" ? 1 : 0 }"
  domain_name     = "${local.domain_name}"
  certificate_arn = "${var.certificate_arn}"
}
