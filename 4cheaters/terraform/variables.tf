variable "profile" {
  type = "string"
}

variable "region" {
  type = "string"
  default = "eu-central-1"
}

variable "vpcCidr" {
  type = "string"
  default = "172.16.0.0/16"
}

variable "TeamName" {
  type = "string"
}

variable "amiID" {
  type = "string"
}

variable "instanceType" {
  type = "string"
  default = "t2.nano"
}

variable "sshkeyname" {
  type = "string"
}