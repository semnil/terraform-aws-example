terraform {
  backend "s3" {
    bucket  = "terraform-aws-example-terraform"
    key     = "global/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "terraform-aws-iac"
    # dynamodb_table = "terraform-aws-example-terraform-lock"
  }
}
