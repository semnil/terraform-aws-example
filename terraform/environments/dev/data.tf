data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "current" {}

data "terraform_remote_state" "global" {
  backend = "s3"

  config = {
    bucket  = "terraform-aws-example-terraform"
    key     = "global/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "terraform-aws-iac"
    # dynamodb_table = "terraform-aws-example-terraform-lock"
  }
}
