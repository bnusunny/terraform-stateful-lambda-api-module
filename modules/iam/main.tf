resource "aws_iam_role" "iam_role_for_lambda" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = [
      "sts:AssumeRole"]
  }
}

data "aws_partition" "current" {}

data "aws_iam_policy" "AWSLambdaVPCAccessExecutionRole" {
  arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

data "aws_iam_policy" "AmazonElasticFileSystemClientFullAccess" {
  arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonElasticFileSystemClientFullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole-attach" {
  role       = aws_iam_role.iam_role_for_lambda.name
  policy_arn = data.aws_iam_policy.AWSLambdaVPCAccessExecutionRole.arn
}

resource "aws_iam_role_policy_attachment" "AmazonElasticFileSystemClientFullAccess-attach" {
  role       = aws_iam_role.iam_role_for_lambda.name
  policy_arn = data.aws_iam_policy.AmazonElasticFileSystemClientFullAccess.arn
}
