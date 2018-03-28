resource "aws_api_gateway_authorizer" "basic" {
  # count                  = "${var.basic_auth_enabled ? 1 : 0}" // ...until 'count' will be supported for modules
  name                   = "basic-auth"
  rest_api_id            = "${aws_api_gateway_rest_api.main.id}"
  authorizer_uri         = "${module.lambda_authorizer.invoke_arn}"
  authorizer_credentials = "${aws_iam_role.main.arn}"
}
