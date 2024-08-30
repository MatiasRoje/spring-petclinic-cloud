After starting Jenkins, install all recommended plugins and “GitHub Integration, Docker, Docker Pipeline, Jacoco, AnsiColor, Copy Artifact, Deploy to container, Job DSL, SonarQube Scanner, Amazon EC2, Terraform, Pipeline Maven Integration".

# Install Maven
wget https://downloads.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz
tar xvf apache-maven-3.9.5-bin.tar.gz
sudo mv apache-maven-3.9.5 /usr/local/apache-maven
vim ~/.bashrc and add to the file:
"
export M2_HOME=/usr/local/apache-maven
export M2=$M2_HOME/bin
export PATH=$M2:$PATH
"
source ~/.bashrc
mvn -version

# Install Helm:
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm version

# Install kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.2/2024-07-12/bin/linux/amd64/kubectl
chmod +x ./kubectl
kubectl version #NOTE: it shows an error, ignore for the moment

# Install Kompose
curl -L https://github.com/kubernetes/kompose/releases/download/v1.34.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose
kompose version

# Start the terraform S3 bucket via terraform/
cd terraform/
terraform apply

# install Helm-S3 plugin
helm plugin install https://github.com/hypnoglow/helm-s3.git
sudo su -s /bin/bash jenkins
export PATH=$PATH:/usr/local/bin
exit

# Create index.yaml in the bucket and start the helm repository
AWS_REGION=eu-west-1 helm s3 init s3://petclinic-helm-charts-datascientest/stable/myapp
aws s3 ls s3://petclinic-helm-charts-datascientest/stable/myapp/
helm repo ls # No any repo will appear.
AWS_REGION=eu-west-1 helm repo add stable-petclinicapp s3://petclinic-helm-charts-datascientest/stable/myapp/
helm repo ls

# update the chart.yaml file and send it to the s3 bucket
cd kubernetes/
# version: 0.0.1
# appVersion: 0.1.0
helm package petclinic_chart/
HELM_S3_MODE=3 AWS_REGION=eu-west-1 helm s3 push ./petclinic_chart-0.1.0.tgz stable-petclinicapp
helm search repo stable-petclinicapp

### Setting a DNS record skipped, microservices-5 can be revisited later

### Setting a Rancher server skipped, microservices-6 and 7 can be revisitated later

28/08
Create ECR repository in AWS:
Freestyle project: "create-ecr-docker-registry-for-petclinic-staging"

Go to the build step section, and select “Execute Shell” from the drop-down menu. Then, copy the following content, and paste the “Execute Shell” box:

"
PATH="$PATH:/usr/local/bin"
APP_REPO_NAME="datascientest-project/petclinic-staging"
AWS_REGION="eu-west-1"

aws ecr describe-repositories --region ${AWS_REGION} --repository-name ${APP_REPO_NAME} || \
aws ecr create-repository \
  --repository-name ${APP_REPO_NAME} \
  --image-scanning-configuration scanOnPush=false \
  --image-tag-mutability MUTABLE \
  --region ${AWS_REGION}
"