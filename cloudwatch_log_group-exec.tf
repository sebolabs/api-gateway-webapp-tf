resource "aws_cloudwatch_log_group" "exec_logs" {
  count             = "${var.exec_logs_enabled ? 1 : 0}"
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.main.id}/${var.stage_name}"
  retention_in_days = "${var.exec_logs_cwlg_retention_in_days}"

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
        "exec-logs"
      )
    )
  )}"
}
