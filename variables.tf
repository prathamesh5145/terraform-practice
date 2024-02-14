variable "project" {
  default = "cloudblitz"
}

variable "env" {
  default = "dev"
}

variable "instance_id" {
  default = "ami-03f4878755434977f"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "prathamesh"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "private_subnet_cidr" {
  default = "192.168.0.0/20"
}

variable "public_subnet_cidr" {
  default = "192.168.16.0/20"
}