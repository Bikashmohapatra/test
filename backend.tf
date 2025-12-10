terraform {
  backend "s3" {
    bucket         = "replicationtestingv1"   # S3 bucket name
    key            = "Terraformstate/terraform.tfstate"   # path inside bucket
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"              # for state locking
    encrypt        = true                          # enable SSE encryption
  }
}