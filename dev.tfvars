region        = "ap-south-1"
environment   = "dev"
vpc_cidr      = "10.0.0.0/16"
instance_type = "t2.micro"
bucket_name   = "dev-logs-unique-12345"

# Resource-specific tags
tags = {
  Project = "TerraformAssessment"
  Owner   = "CloudTeam"
}

# Shared/common tags inside modules
common_tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
}