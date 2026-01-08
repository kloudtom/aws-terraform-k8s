data "aws_ami" "amazon_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"] # official Canonical AWS account that publishes Ubuntu AMIs.

}

############################
# Query Master Nodes
############################
data "aws_instances" "masters" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = ["k8s-master-asg"]
  }

  depends_on = [
    module.asg_master
  ]
}

############################
# Query Worker Nodes
############################
data "aws_instances" "workers" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = ["k8s-worker-asg"]
  }

  depends_on = [
    module.asg_worker
  ]
}
