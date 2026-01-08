resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [var.bastion_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    master_hosts = var.master_hosts
    worker_hosts = var.worker_hosts
    private_key  = var.ssh_private_key
  })

  tags = {
    Name = "k8s-bastion"
  }
}
