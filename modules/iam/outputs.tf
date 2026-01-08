output "master_instance_profile" {
  value = aws_iam_instance_profile.master_profile.name
}

output "worker_instance_profile" {
  value = aws_iam_instance_profile.worker_profile.name
}
