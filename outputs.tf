output "rest_api_id" {
  value = "${aws_api_gateway_rest_api.main.id}"
}

output "invoke_url" {
  value = "${aws_api_gateway_deployment.main.invoke_url}"
}

output "route53_alias_fqdn" {
  value = "${aws_route53_record.alias.*.fqdn}"
}
