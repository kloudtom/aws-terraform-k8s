master_asg = {
  ami_id           = "ami-0abcdef1234567890"
  instance_type    = "t3.medium"
  desired_capacity = 1
  min_size         = 1
  max_size         = 1
}

worker_asg = {
  ami_id           = "ami-0abcdef1234567890"
  instance_type    = "t3.medium"
  desired_capacity = 2
  min_size         = 1
  max_size         = 3
}
aws_profile         = "dev"
aws_region          = "us-east-1"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
key_name            = "jan3"
bastion_ssh_cidr    = "0.0.0.0/0"