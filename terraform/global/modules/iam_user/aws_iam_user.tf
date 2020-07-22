# CircleCI用のアクセスキーを用意するために作成
resource "aws_iam_user" "circleci" {
  name = "${var.prefix}-circleci"
}
