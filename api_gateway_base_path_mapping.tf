resource "aws_api_gateway_base_path_mapping" "main" {
  count       = "${var.public_domain_name != "" ? 1 : 0 }"
  api_id      = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${aws_api_gateway_deployment.main.stage_name}"
  domain_name = "${aws_api_gateway_domain_name.main.domain_name}"
}
