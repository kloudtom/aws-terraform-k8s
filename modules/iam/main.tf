############################
# Master Role
############################
resource "aws_iam_role" "k8s_master_role" {
  name = "k8s_master_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

data "aws_iam_policy" "k8s_master_policy" {
  name = "k8s_master_policy"
}

resource "aws_iam_role_policy_attachment" "master_attach" {
  role       = aws_iam_role.k8s_master_role.name
  policy_arn = data.aws_iam_policy.k8s_master_policy.arn
}

resource "aws_iam_instance_profile" "master_profile" {
  name = "k8s-master-profile"
  role = aws_iam_role.k8s_master_role.name
}

############################
# Worker Role
############################
resource "aws_iam_role" "k8s_worker_role" {
  name = "k8s_worker_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

data "aws_iam_policy" "k8s_worker_policy" {
  name = "k8s_worker_policy"
}

resource "aws_iam_role_policy_attachment" "worker_attach" {
  role       = aws_iam_role.k8s_worker_role.name
  policy_arn = data.aws_iam_policy.k8s_worker_policy.arn
}

resource "aws_iam_instance_profile" "worker_profile" {
  name = "k8s-worker-profile"
  role = aws_iam_role.k8s_worker_role.name
}
