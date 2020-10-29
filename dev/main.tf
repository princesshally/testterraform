module "my_vpc" {
  source         = "./modules/vpc"
  vpc_cidr       = "192.168.0.0/16"
  tenancy        = "default"
  vpc_id         = module.my_vpc.vpc_id
  subnet_cidr    = "192.168.1.0/24"
  subnet_id      = module.my_vpc.subnet_id
  igw_id         = module.my_vpc.igw_id
  route_table_id = module.my_vpc.route_table_id
  sg_name        = "Terra-SG"
}

module "my_ec2" {
  source         = "./modules/ec2"
  ec2_count      = 1
  ami_id         = "ami-0947d2ba12ee1ff75"
  instance_type  = "t2.micro"
  subnet_id = module.my_vpc.subnet_id
}
