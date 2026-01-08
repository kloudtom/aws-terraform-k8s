variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}


variable "master_hosts" {
  type = list(string)
}
variable "master_host_first" {
  type = string
}
variable "worker_hosts" {
  type = list(string)
}
variable "bastion_ssh_cidr" {
  description = "CIDR block allowed to SSH into bastion"
  type        = string
}
variable "bastion_sg_id" {
  description = "Security group ID for the bastion host"
  type        = string
}

variable "key_name" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "ssh_private_key" {
  description = "Private SSH key used by bastion to connect to k8s nodes"
  type        = string
  sensitive   = true
}