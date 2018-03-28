resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  parent_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_any" {
  rest_api_id      = "${aws_api_gateway_rest_api.main.id}"
  resource_id      = "${aws_api_gateway_resource.proxy.id}"
  http_method      = "ANY"
  authorization    = "${local.authorization}"
  authorizer_id    = "${local.authorizer_id}"
  api_key_required = false

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "proxy_any" {
  rest_api_id             = "${aws_api_gateway_rest_api.main.id}"
  resource_id             = "${aws_api_gateway_resource.proxy.id}"
  http_method             = "${aws_api_gateway_method.proxy_any.http_method}"
  type                    = "AWS_PROXY"
  uri                     = "${var.integration_uri}"
  integration_http_method = "POST"
}

resource "aws_api_gateway_method_response" "proxy_any_200" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_resource.proxy.id}"
  http_method = "${aws_api_gateway_method.proxy_any.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "proxy_any_200" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_resource.proxy.id}"
  http_method = "${aws_api_gateway_method.proxy_any.http_method}"
  status_code = "${aws_api_gateway_method_response.proxy_any_200.status_code}"
  depends_on  = ["aws_api_gateway_integration.proxy_any"]
}
