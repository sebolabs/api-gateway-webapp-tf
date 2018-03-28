data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "AllowApiGatewayAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}
