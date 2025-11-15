variable "region" {
  type        = string
  description = "AWS region, e.g. eu-north-1"
}

variable "name" {
  type        = string
  description = "Short cluster/team name used for tags and prefixes"
  default     = "wits-a"
}

variable "vpc_id" {
  type        = string
  description = "Target VPC ID (vpc-xxxxxxxx)"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC (e.g. 172.31.0.0/16)"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID (subnet-xxxxxxxx) to place the instance in"
}

variable "ami_id" {
  type        = string
  description = "Ubuntu AMI ID in your region (e.g. ami-xxxxxxxx)"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.small"   # use t3.micro if you want smaller
}

variable "ssh_cidr" {
  type        = string
  description = "Your public IP in CIDR form, e.g. 105.242.69.70/32"
}

variable "public_key" {
  type        = string
  description = "Your SSH public key (single line: ssh-ed25519 ...)"
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 Key Pair in AWS (e.g., wits-a-key)"
}

variable "ssh_user" {
  type        = string
  description = "Default SSH username for the AMI"
  default     = "ubuntu"
}
