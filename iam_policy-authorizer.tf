data "aws_iam_policy_document" "authorizer" {
  count = "${var.basic_auth_enabled ? 1 : 0}"

  statement {
    sid    = "AllowInvokeAuthLambda"
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
    ]

    resources = [
      "${module.lambda_authorizer.arn}",
    ]
  }
}

resource "aws_iam_policy" "authorizer" {
  count = "${var.basic_auth_enabled ? 1 : 0}"

  name = "${format(
    "%s-%s-%s-%s",
    var.project,
    var.environment,
    var.component,
    "authorizer"
  )}"

  description = "Authorizer policy"
  policy      = "${data.aws_iam_policy_document.authorizer.json}"
}

resource "aws_iam_policy_attachment" "authorizer" {
  count = "${var.basic_auth_enabled ? 1 : 0}"

  name = "${format(
    "%s-%s-%s-%s",
    var.project,
    var.environment,
    var.component,
    "authorizer"
  )}"

  roles      = ["${aws_iam_role.main.name}"]
  policy_arn = "${aws_iam_policy.authorizer.arn}"
}
