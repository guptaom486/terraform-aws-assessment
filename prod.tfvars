region        = "ap-south-1"
environment   = "prod"
vpc_cidr      = "10.1.0.0/16"
instance_type = "t3.medium"
bucket_name   = "prod-logs-unique-12345"

# Resource-specific tags
tags = {
  Project = "TerraformAssessment"
  Owner   = "CloudTeam"
}

# Shared/common tags inside modules
common_tags = {
  Environment = "prod"
  ManagedBy   = "Terraform"
}