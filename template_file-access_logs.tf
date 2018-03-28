data "template_file" "access_log_format" {
  count    = "${var.access_logs_enabled ? 1 : 0}"
  template = "${file("${path.module}/templates/access_log_format.json.tpl")}"
}
