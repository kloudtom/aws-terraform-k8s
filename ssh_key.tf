resource "tls_private_key" "k8s_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "k8s_key" {
  key_name   = "k8s-ssh-key"
  public_key = tls_private_key.k8s_ssh.public_key_openssh
}

resource "local_file" "k8s_private_key" {
  filename        = "${path.root}/k8s-ssh-key.pem"
  content         = tls_private_key.k8s_ssh.private_key_pem
  file_permission = "0400"
}

resource "local_file" "k8s_public_key" {
  filename        = "${path.root}/k8s-ssh-key.pub"
  content         = tls_private_key.k8s_ssh.public_key_openssh
  file_permission = "0400"
}