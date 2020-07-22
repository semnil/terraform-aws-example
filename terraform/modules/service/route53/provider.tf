provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "dbd-${var.prefix}-iac-terraform"
}
