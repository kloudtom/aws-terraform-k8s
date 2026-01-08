variable "master_asg" {
  type = object({
    ami_id           = string
    instance_type    = string
    desired_capacity = number
    min_size         = number
    max_size         = number
  })
}

variable "worker_asg" {
  type = object({
    ami_id           = string
    instance_type    = string
    desired_capacity = number
    min_size         = number
    max_size         = number
  })
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
}
variable "bastion_ssh_cidr" {
  description = "CIDR block allowed to SSH into bastion host"
  type        = string
}
variable "key_name" {
  type = string
}