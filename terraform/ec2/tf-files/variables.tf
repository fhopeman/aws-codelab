variable "profile" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "azs" {
  type = "list"
}

variable "vpc_cidr" {
  type = "string"
}

variable "subnet_cidrs" {
  type = "list"
}

variable "team_name" {
  type = "string"
}

variable "ami_id" {
  type = "string"
}

variable "instance_type" {
  type = "string"
}

variable "sshkeyname" {
  type = "string"
}
