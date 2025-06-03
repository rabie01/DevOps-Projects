terraform {
  backend "s3" {
    bucket         = "mybucett21000"
    key            = "terraform/project01/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"  # optional but recommended for state locking
  }
}
