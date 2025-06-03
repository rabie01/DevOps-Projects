terraform {
  backend "s3" {
    bucket         = var.war_s3_bucket
    key            = var.tf_s3_key
    region         = var.aws_region
    dynamodb_table = "terraform-lock"  # optional but recommended for state locking
  }
}
