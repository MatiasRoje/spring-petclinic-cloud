mykey                = "jenkins-dst"
ami                  = "ami-0e141aee2812422a2"
region               = "eu-west-3"
instance_type        = "t3a.medium" #  can try large if medium doesn't work
jenkins_server_secgr = "petclinic-jenkins-server-secgr"
jenkins-server-tag   = "Petclinic Jenkins Server"
jenkins-profile      = "petclinic-jenkins-server-profile"
jenkins-role         = "petclinic-jenkins-server-role"