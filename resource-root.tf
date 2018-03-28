resource "aws_api_gateway_method" "root_get" {
  rest_api_id      = "${aws_api_gateway_rest_api.main.id}"
  resource_id      = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method      = "GET"
  authorization    = "${local.authorization}"
  authorizer_id    = "${local.authorizer_id}"
  api_key_required = false

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "root_get" {
  rest_api_id             = "${aws_api_gateway_rest_api.main.id}"
  resource_id             = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method             = "${aws_api_gateway_method.root_get.http_method}"
  type                    = "AWS_PROXY"
  uri                     = "${var.integration_uri}"
  integration_http_method = "POST"
}

resource "aws_api_gateway_method_response" "root_get_200" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method = "${aws_api_gateway_method.root_get.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "root_get_200" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method = "${aws_api_gateway_method.root_get.http_method}"
  status_code = "${aws_api_gateway_method_response.root_get_200.status_code}"
  depends_on  = ["aws_api_gateway_integration.root_get"]
}
