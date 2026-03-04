module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
  tags        = var.common_tags
}

module "ec2" {
  source            = "./modules/ec2"
  private_subnet_id = module.vpc.private_subnet_ids[0]
  vpc_id            = module.vpc.vpc_id
  vpc_cidr          = var.vpc_cidr        # ⚡ Added for SSH rule
  instance_type     = var.instance_type
  environment       = var.environment
  tags              = var.common_tags     # Resource-specific tags
  common_tags       = var.common_tags     # Shared tags inside module
  bucket_name       = var.bucket_name     # For logs
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  environment = var.environment
  tags        = var.common_tags
}