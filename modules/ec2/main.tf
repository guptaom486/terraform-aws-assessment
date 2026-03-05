
# Get Latest Amazon Linux AMI

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}


# Security Group - Add SSH Ingress Rule

resource "aws_security_group" "this" {
  name        = "${var.environment}-ec2-sg"
  description = "Private EC2 security group"
  vpc_id      = var.vpc_id

  # ⚡ SSH inbound from VPC CIDR
  ingress {
    description = "SSH from VPC CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ⚡ Merge tags with common_tags
  tags = merge(var.tags, var.common_tags, {
    Name = "${var.environment}-ec2-sg"
  })
}


# IAM Role for SSM Access

resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = merge(var.tags, var.common_tags)   # ⚡ Updated
}

# Attach AWS Managed Policy for SSM

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.environment}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}


# EC2 Instance (Private Subnet Only)

resource "aws_instance" "this" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  iam_instance_profile   = aws_iam_instance_profile.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  # IMPORTANT: No public IP
  associate_public_ip_address = false

  user_data = <<-EOF
#!/bin/bash
yum update -y
echo "EC2 provisioned successfully" > /home/ec2-user/status.txt
EOF

  # ⚡ Merge tags with common_tags
  tags = merge(var.tags, var.common_tags, {
    Name = "${var.environment}-private-ec2"
  })
}

