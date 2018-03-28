resource "aws_cloudwatch_log_group" "access_logs" {
  count             = "${var.access_logs_enabled ? 1 : 0}"
  name              = "/aws/apigateway/${aws_api_gateway_rest_api.main.id}"
  retention_in_days = "${var.access_logs_cwlg_retention_in_days}"

  tags = "${merge(
    var.default_tags,
    local.tags,
    map(
      "Name", format(
        "%s-%s-%s/%s/%s",
        var.project,
        var.environment,
        var.component,
        var.name,
        "access-logs"
      )
    )
  )}"
}

resource "null_resource" "gateway_access_logging" {
  count = "${var.access_logs_enabled ? 1 : 0}"

  triggers {
    log_group  = "${aws_cloudwatch_log_group.access_logs.arn}"
    log_format = "${data.template_file.access_log_format.rendered}"
  }

  provisioner "local-exec" {
    command = "aws apigateway update-stage --rest-api-id ${aws_api_gateway_rest_api.main.id} --stage-name ${aws_api_gateway_deployment.main.stage_name} --patch-operations op=replace,path=/accessLogSettings/destinationArn,value='arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.access_logs.name}' --region ${data.aws_region.current.name}"
  }

  provisioner "local-exec" {
    command = "aws apigateway update-stage --rest-api-id ${aws_api_gateway_rest_api.main.id} --stage-name ${aws_api_gateway_deployment.main.stage_name} --patch-operations 'op=replace,path=/accessLogSettings/format,value=${jsonencode(replace(data.template_file.access_log_format.rendered, "\n", ""))}' --region ${data.aws_region.current.name}"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "aws apigateway update-stage --rest-api-id ${aws_api_gateway_rest_api.main.id} --stage-name ${aws_api_gateway_deployment.main.stage_name} --patch-operations op=remove,path=/accessLogSettings,value= --region ${data.aws_region.current.name}"
  }

  depends_on = [
    "aws_cloudwatch_log_group.access_logs",
    "aws_api_gateway_deployment.main",
  ]
}
