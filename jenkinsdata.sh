#! /bin/bash
# update os
sudo yum update -y
# set server hostname as jenkins-server
sudo hostnamectl set-hostname jenkins-server
# install git
sudo yum install git -y
# install java 11
sudo dnf install java-11-amazon-corretto -y
# install jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo install java-openjdk11 -y
sudo dnf install java-11-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
# install docker
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker jenkins
# configure docker as cloud agent for jenkins
sudo cp /lib/systemd/system/docker.service /lib/systemd/system/docker.service.bak
sudo sed -i 's/^ExecStart=.*/ExecStart=\/usr\/bin\/dockerd -H tcp:\/\/127.0.0.1:2375 -H unix:\/\/\/var\/run\/docker.sock/g' /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart jenkins
# install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# install aws cli version 2
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
# install python 3 and pip
sudo yum install python3 -y
python3 -m ensurepip --upgrade
# install ansible
pip3 install ansible
# install boto3
pip3 install boto3
# install terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install terraform -y

# install kubectl
sudo curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.2/2024-07-12/bin/linux/amd64/kubectl
=chmod +x ./kubectl
sudo mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
sudo rm kubectl


sudo curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
sudo helm plugin install https://github.com/hypnoglow/helm-s3.git

sudo su -s /bin/bash jenkins
export PATH=$PATH:/usr/local/bin