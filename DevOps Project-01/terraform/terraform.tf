terraform {
  backend "s3" {
    bucket         = "mybuckett21000"
    key            = "terraform/project01/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile = "terraform-lock"  # optional but recommended for state locking
  }
}
