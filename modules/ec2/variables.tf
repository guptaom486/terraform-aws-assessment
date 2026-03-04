variable "private_subnet_id" {}
variable "vpc_id" {}
variable "instance_type" {}
variable "environment" {}
variable "tags" {
  type = map(string)
}

# ⚡ Newly added variables
variable "vpc_cidr" {}        # Needed for SSH ingress
variable "common_tags" {      # Shared tags inside module
  type = map(string)
}
variable "bucket_name" {}     # For logs bucket in EC2 module