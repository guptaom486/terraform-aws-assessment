variable "region" {}
variable "environment" {}
variable "vpc_cidr" {}
variable "instance_type" {}
variable "bucket_name" {}

variable "tags" {
  type = map(string)
}

variable "common_tags" {
  type = map(string)
}