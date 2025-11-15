terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_key_pair" "team" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "compute_sg" {
  name   = "${var.name}-compute-sg"
  vpc_id = var.vpc_id

  # SSH from your public IP
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  # Allow intra-VPC traffic (all ports/protocols) so nodes can talk
  ingress {
    description = "Intra-VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  # Outbound anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "compute3" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.compute_sg.id]
  key_name                    = aws_key_pair.team.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.name}-compute-3"
    Role = "compute"
  }

  # Ensure python for Ansible
  user_data = <<-EOF
    #!/bin/bash
    set -eux
    if command -v apt-get >/dev/null 2>&1; then
      apt-get update -y && apt-get install -y python3
    elif command -v dnf >/dev/null 2>&1; then
      dnf -y install python3
    fi
  EOF
}

output "ansible_inventory" {
  value = <<-EOT
[compute]
${aws_instance.compute3.public_ip} ansible_user=${var.ssh_user}
EOT
}
