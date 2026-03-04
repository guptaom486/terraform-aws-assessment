# Terraform AWS Infrastructure Assessment

## Overview

This repository contains a modular Terraform implementation to provision a secure and reusable AWS infrastructure. The objective of this project is to demonstrate infrastructure-as-code best practices, modular design, and environment-based configuration management.

The setup focuses on clarity, security, and maintainability rather than over-engineering.

---

## Architecture

The following components are provisioned:

- Custom VPC (10.0.0.0/16)
- Public and Private subnets across multiple Availability Zones
- Internet Gateway with public route table
- EC2 instance deployed in a private subnet
- IAM role and instance profile attached to EC2
- S3 bucket for application/log storage
- Consistent tagging across all resources

The EC2 instance is deployed privately.

---

## Project Structure

- Root configuration files (providers, variables, outputs)
- Separate reusable modules for:
  - VPC
  - EC2
  - S3
- Environment-specific configuration using:
  - `dev.tfvars`
  - `prod.tfvars`

This structure keeps the code reusable and environment-agnostic.

---

## How to Deploy

```bash
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
same for prod Environment
==============================

##Assumptions

AWS credentials are configured locally via AWS CLI or IAM role.
The Amazon Linux AMI includes the SSM agent by default.
The EC2 instance does not require direct internet access.
S3 bucket names are globally unique.
Local Terraform state is acceptable for assessment purposes.

##Trade-offs & Design Decisions

A NAT Gateway was not included to keep the solution simple and cost-effective.
High availability features such as Auto Scaling or Load Balancers were intentionally excluded to focus on structure and modularization and this is for assessment only.
Remote backend (S3 + DynamoDB) was not configured to avoid unnecessary complexity for this scope.
