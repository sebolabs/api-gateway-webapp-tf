resource "aws_route53_record" "alias" {
  count   = "${var.public_domain_name != "" ? 1 : 0 }"
  name    = "${var.dns_alias != "" ? var.dns_alias : "${var.custom_env_alias_prefix}-${var.environment}"}"
  zone_id = "${data.aws_route53_zone.public.zone_id}"
  type    = "A"

  alias {
    name                   = "${aws_api_gateway_domain_name.main.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.main.cloudfront_zone_id}"
    evaluate_target_health = false
  }

  depends_on = ["aws_api_gateway_domain_name.main"]
}
