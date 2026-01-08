module "network" {
  source = "./modules/network"

  azs                  = ["us-east-1a", "us-east-1b"]
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

module "iam" {
  source = "./modules/iam"
}


module "asg_master" {
  source = "./modules/asg"

  name               = "k8s-master-asg"
  ami_id             = data.aws_ami.amazon_ubuntu.id
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  instance_profile   = module.iam.master_instance_profile
  k8s_nodes_sg_id    = aws_security_group.k8s_nodes_sg.id
  instance_type      = var.master_asg.instance_type
  desired_capacity   = var.master_asg.desired_capacity
  min_size           = var.master_asg.min_size
  max_size           = var.master_asg.max_size
  key_name           = aws_key_pair.k8s_key.key_name
  node_tags = {
    "Name"                                = "master-node"
    "kubernetes.io/cluster/cluster.local" = "owned"
    "kubespray-role"                      = "kube_control_plane, etcd"
  }
}
module "asg_worker" {
  source = "./modules/asg"

  name               = "k8s-worker-asg"
  ami_id             = data.aws_ami.amazon_ubuntu.id
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  instance_profile   = module.iam.worker_instance_profile
  k8s_nodes_sg_id    = aws_security_group.k8s_nodes_sg.id
  instance_type      = var.worker_asg.instance_type
  desired_capacity   = var.worker_asg.desired_capacity
  min_size           = var.worker_asg.min_size
  max_size           = var.worker_asg.max_size
  key_name           = aws_key_pair.k8s_key.key_name

  node_tags = {
    "Name"                                = "worker-node"
    "kubernetes.io/cluster/cluster.local" = "owned"
    "kubespray-role"                      = "kube_node, etcd"
  }
}

module "bastion" {
  source = "./modules/bastion"

  vpc_id            = module.network.vpc_id
  ami_id            = data.aws_ami.amazon_ubuntu.id
  public_subnet_ids = module.network.public_subnet_ids
  bastion_ssh_cidr  = var.bastion_ssh_cidr
  bastion_sg_id     = aws_security_group.bastion_sg.id
  master_hosts      = data.aws_instances.masters.private_ips
  worker_hosts      = data.aws_instances.workers.private_ips
  key_name          = aws_key_pair.k8s_key.key_name
  ssh_private_key   = tls_private_key.k8s_ssh.private_key_pem
}
