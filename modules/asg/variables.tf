variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_profile" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "node_tags" {
  type = map(string)
}

variable "vpc_id" {}


variable "key_name" {
  type = string
}
variable "k8s_nodes_sg_id" {
  type = string
}
variable "ami_id" {
  type = string
}