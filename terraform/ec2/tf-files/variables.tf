variable "profile" {
  type = "string"
}

variable "region" {
  type = "string"
  default = "eu-central-1"
}

variable "vpc_cidr" {
  type = "string"
  default = "172.16.0.0/16"
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
