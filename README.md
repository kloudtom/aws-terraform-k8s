# aws-terraform-k8s
icacls C:\AI_OPS\aws-terraform-k8s\k8s-ssh-key.pem /inheritance:r
icacls C:\AI_OPS\aws-terraform-k8s\k8s-ssh-key.pem /remove:g *S-1-1-0
icacls C:\AI_OPS\aws-terraform-k8s\k8s-ssh-key.pem /remove:g *S-1-5
icacls C:/AI_OPS/aws-terraform-k8s/k8s-ssh-key.pem /grant "${env:USERNAME}:(R)"
or
icacls C:\AI_OPS\aws-terraform-k8s\k8s-ssh-key.pem /grant %USERNAME%:(R)
