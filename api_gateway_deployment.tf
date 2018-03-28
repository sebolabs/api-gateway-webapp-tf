resource "aws_api_gateway_deployment" "main" {
  rest_api_id       = "${aws_api_gateway_rest_api.main.id}"
  stage_name        = "${var.stage_name == "" ? var.environment : var.stage_name }"
  stage_description = "${local.stage_description}"
  description       = "Deployed at: ${timestamp()}"

  lifecycle {
    ignore_changes        = ["description"]
    create_before_destroy = true
  }

  depends_on = [
    "aws_api_gateway_method.root_get",
    "aws_api_gateway_integration.root_get",
    "aws_api_gateway_method_response.root_get_200",
    "aws_api_gateway_integration_response.root_get_200",
    "aws_api_gateway_method.proxy_any",
    "aws_api_gateway_integration.proxy_any",
    "aws_api_gateway_method_response.proxy_any_200",
    "aws_api_gateway_integration_response.proxy_any_200",
    "aws_api_gateway_method.assets_item_get",
    "aws_api_gateway_integration.assets_item_get",
    "aws_api_gateway_method_response.assets_item_get_200",
    "aws_api_gateway_integration_response.assets_item_get_200",
  ]
}
