data "aws_route53_zone" "public" {
  count = "${var.public_domain_name != "" ? 1 : 0 }"
  name  = "${var.public_domain_name}."
}
