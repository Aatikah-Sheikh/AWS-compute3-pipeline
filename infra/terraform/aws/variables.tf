variable "region"      { type = string }
variable "name"        { type = string }
variable "vpc_id"      { type = string }
variable "vpc_cidr"    { type = string }
variable "subnet_id"   { type = string }

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "ami_id"      { type = string }
variable "ssh_cidr"    { type = string }   # YOUR.PUBLIC.IP/32
variable "key_name"    { type = string }
variable "public_key"  { type = string }

variable "ssh_user" {
  type    = string
  default = "ubuntu"
}
