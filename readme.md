# AWS Infrastructure via Terraform

This repository creates a VPC with multiple subnets, a Kubernetes EKS Cluster, and an RDS database. It also includes compatibility with Helm, Velero, Prometheus and Grafana.

# run
terraform apply -var-file="secret.tfvars"

terraform destroy -var-file="secret.tfvars"