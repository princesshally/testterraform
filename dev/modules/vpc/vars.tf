variable "vpc_cidr" {
  default = "10.0.0.0/16"
}  

variable "tenancy" {
  default = "default"
}  

variable "vpc_id" {}
  
variable "subnet_cidr" {
  default = "10.0.1.0/24"
}  

variable "igw_id" {}

variable "subnet_id" {}

variable "route_table_id" {}

variable "sg_name" {}

variable "sg_description" {
  default = "security Group for VPC"
}
