resource "aws_api_gateway_resource" "assets" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  parent_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  path_part   = "assets"
}

resource "aws_api_gateway_resource" "assets_item" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  parent_id   = "${aws_api_gateway_resource.assets.id}"
  path_part   = "{item+}"
}

resource "aws_api_gateway_method" "assets_item_get" {
  rest_api_id      = "${aws_api_gateway_rest_api.main.id}"
  resource_id      = "${aws_api_gateway_resource.assets_item.id}"
  http_method      = "GET"
  authorization    = "${local.authorization}"
  authorizer_id    = "${local.authorizer_id}"
  api_key_required = false

  request_parameters = {
    "method.request.path.item" = true
  }
}

resource "aws_api_gateway_integration" "assets_item_get" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_resource.assets_item.id}"
  http_method = "${aws_api_gateway_method.assets_item_get.http_method}"
  type        = "AWS"

  uri = "${format(
    "%s:%s:%s/%s/%s/%s",
    "arn:aws:apigateway",
    data.aws_region.current.name,
    "s3:path",
    var.assets_s3_bucket_name,
    var.assets_s3_bucket_path,
    "{object}",
  )}"

  integration_http_method = "${aws_api_gateway_method.assets_item_get.http_method}"
  credentials             = "${aws_iam_role.main.arn}"

  request_parameters = {
    "integration.request.path.object" = "method.request.path.item"
  }

  depends_on = ["aws_api_gateway_method.assets_item_get"]
}

resource "aws_api_gateway_method_response" "assets_item_get_200" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_resource.assets_item.id}"
  http_method = "${aws_api_gateway_method.assets_item_get.http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Date"           = true
    "method.response.header.ETag"           = true
    "method.response.header.Content-Length" = true
    "method.response.header.Content-Type"   = true
    "method.response.header.Last-Modified"  = true
    "method.response.header.Cache-Control"  = true
  }

  depends_on = ["aws_api_gateway_integration.assets_item_get"]
}

resource "aws_api_gateway_integration_response" "assets_item_get_200" {
  rest_api_id       = "${aws_api_gateway_rest_api.main.id}"
  resource_id       = "${aws_api_gateway_resource.assets_item.id}"
  http_method       = "${aws_api_gateway_method.assets_item_get.http_method}"
  status_code       = "${aws_api_gateway_method_response.assets_item_get_200.status_code}"
  selection_pattern = "200"

  response_parameters = {
    "method.response.header.Content-Length" = "integration.response.header.Content-Length"
    "method.response.header.Content-Type"   = "integration.response.header.Content-Type"
    "method.response.header.Date"           = "integration.response.header.Date"
    "method.response.header.ETag"           = "integration.response.header.ETag"
    "method.response.header.Last-Modified"  = "integration.response.header.Last-Modified"
    "method.response.header.Cache-Control"  = "integration.response.header.Cache-Control"
  }

  content_handling = "CONVERT_TO_BINARY"
  depends_on       = ["aws_api_gateway_integration.assets_item_get"]
}
