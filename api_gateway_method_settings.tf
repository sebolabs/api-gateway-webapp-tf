resource "aws_api_gateway_method_settings" "main" {
  count       = "${var.exec_logs_enabled ? 1 : 0}"
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${aws_api_gateway_deployment.main.stage_name}"
  method_path = "*/*"

  settings {
    logging_level      = "${var.exec_logs_logging_level}"
    metrics_enabled    = "${var.exec_logs_metrics_enabled}"
    data_trace_enabled = "${var.exec_logs_data_trace_enabled}"
  }
}
