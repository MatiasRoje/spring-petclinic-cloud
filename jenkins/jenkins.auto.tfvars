mykey                = "jenkins"
ami                  = "ami-04e49d62cf88738f1"
region               = "eu-west-1"
instance_type        = "t3a.medium" #  can try large if medium doesn't work
jenkins_server_secgr = "petclinic-jenkins-server-secgr"
jenkins-server-tag   = "Petclinic Jenkins Server"
jenkins-profile      = "petclinic-jenkins-server-profile"
jenkins-role         = "petclinic-jenkins-server-role"