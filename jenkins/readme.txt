After starting the Jenkins server and setup a password, install all recommended plugins:
"GitHub Integration, Docker, Docker Pipeline, Deploy to container, Job DSL, Amazon EC2, Parameterized Trigger".

# Optional: Check whether all neccesary tools are correctly installed:
java -version
docker version
python3 -V
terraform version
helm version
kubectl version --client

# Add necessary credentials
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
GITHUB_ID
GITHUB_TOKEN
# DOCKER_ID
# DOCKERHUB_PASSW

# Configure AWS
aws configure

# Check the S3 buckets for terraform are running:
petclinic-project-datascientest

# Use this to connect to EKS cluster
aws eks update-kubeconfig --region eu-west-3 --name petclinic-eks

# Install Argocd
It will be deployed via Jenkins

# get initial admin password for argcd uni
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d