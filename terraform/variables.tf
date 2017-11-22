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

variable "availabilityZones" {
  type = "list"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "TeamName" {
  type = "string"
}

