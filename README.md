# Spring PetClinic Cloud Microservices - DevOps Modernization Project

The initial PetClinic application is a legacy microservices-based Java system, built without following DevOps practices. While functional, it lacks scalability, and the overall software development process could be significantly optimized.

## Project Overview

This project focuses on building a modern CI/CD pipeline and running the application fully in the cloud using AWS and Kubernetes. Our goal is to optimize development workflows and ensure seamless deployment.

### Key Technologies Used
- **AWS Cloud**: Hosting and infrastructure
- **Kubernetes (EKS)**: Orchestration of microservices
- **Helm Charts**: Application deployment on Kubernetes
- **Jenkins**: Continuous Integration (CI)
- **ArgoCD**: Continuous Deployment (CD) and GitOps for Kubernetes manifests
- **Terraform**: Infrastructure as Code (IaC)
- **Prometheus & Grafana**: Monitoring and alerts
- **Velero**: Backup solution for Kubernetes resources
  
## Implementation Details

### 1. **IaC - AWS Infrastructure Setup**
We used Terraform to provision the necessary AWS infrastructure:
- VPC with public and private subnets
- EKS cluster deployed in private subnets
- Multi-AZ RDS database
- Helm, Velero, Prometheus and Grafana

Backend storage for Terraform is managed via an S3 bucket to ensure team collaboration. All Terraform code resides in the `terraform` branch of the repository.

### 2. **Continuous Integration (CI) Pipeline**
We developed a Jenkins CI pipeline to:
- Build and test the application inside Docker images
- Push the images to private ECR repositories
- Automatically update image tags in the Kubernetes repository

### 3. **Continuous Deployment (CD) Pipeline**
ArgoCD, connected via webhook to our Kubernetes repository, listens for changes and automatically deploys the updated images to the staging environment. Production deployments require manual approval. ArgoCD also provides real-time service health monitoring.

### 4. **DNS and HTTPS**
Using AWS Route 53, we configured the domain (https://petclinicdev.online/) to route traffic via an Ingress LoadBalancer. The domain uses an SSL certificate from AWS Certificate Manager for secure HTTPS connections.

### 5. **Monitoring and Alerts**
Prometheus pulls metrics from the EKS cluster, and Grafana visualizes them. We set up alerting to notify our team via Slack when key metrics, such as CPU usage, exceed predefined thresholds.

### 6. **Backup Policy**
Velero stores all backup data from the running Kubernetes cluster in an S3 bucket located in the same AWS Region. It is configured to create daily backups at 3 AM for both production and staging environments. Additionally, AWS RDS provides automated backups by default, ensuring point-in-time recovery for the database in case of any data loss or failure.

---

This project demonstrates the use of modern DevOps tools and best practices to transform a legacy Java application into a scalable, cloud-native system.

