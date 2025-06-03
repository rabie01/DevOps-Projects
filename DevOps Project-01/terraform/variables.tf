
variable "aws_region" {
  default = "us-east-1"
}

variable "war_s3_bucket" {
  default = "mybuckett21000"
}
variable "war_s3_key" {
  default = "artifacts/dptweb-1.0.war"
}



variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  default = "devops-projects"
}

variable "desired_capacity" {
  default = 1
}

variable "ami_id" {
  description = "Base AMI for EC2 (e.g., Amazon Linux 2)"
  default = "ami-0953476d60561c955"
}
