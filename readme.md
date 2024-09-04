# AWS Infrastructure via Terraform

This repository creates aVPC with multiple subnets, a Kubernetes EKS Cluster, and an RDS database. It also includes compatibility with Helm, Prometheus, and Grafana.

# run
terraform apply -var-file="secret.tfvars"
terraform destroy -var-file="secret.tfvars"