pipeline {
    environment {
        AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID")
        AWS_SECRET_ACCESS_KEY = credentials("AWS_SECRET_ACCESS_KEY")
        AWS_DEFAULT_REGION = "eu-west-3"
        ECR_REGISTRY = "339713077897.dkr.ecr.eu-west-3.amazonaws.com"
    }
    agent any

    stages {
        stage("Git Checkout") {
            steps {
                git(
                    url: "https://github.com/MatiasRoje/spring-petclinic-cloud.git",
                    branch: "staging",
                    credentialsId: "GITHUB_ID"
                )
            }
        }
        stage("Setup Env Variable") {
            steps {
                script {
                    env.REPOSITORY_PREFIX = "${ECR_REGISTRY}/petclinic"
                    echo "Repository Prefix set to: ${env.REPOSITORY_PREFIX}"
                }
            }
        }
        stage("Login to ECR") {
            steps {
                script {
                    sh '''
                        aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
                    '''
                }
            }
        }
        stage("Build and Tag Images") {
            steps {
                withMaven(maven: "Maven3.9.9") {
                    sh '''
                        docker --version

                        # Build images
                        mvn -X spring-boot:build-image -Pk8s -DREPOSITORY_PREFIX=$ECR_REGISTRY/petclinic

                        # Tag the images with simpler names
                        docker tag $ECR_REGISTRY/petclinic/spring-petclinic-cloud-api-gateway:latest $REPOSITORY_PREFIX/api-gateway:staging-1.0.$BUILD_NUMBER

                        docker tag $ECR_REGISTRY/petclinic/spring-petclinic-cloud-customers-service:latest $REPOSITORY_PREFIX/customers-service:staging-1.0.$BUILD_NUMBER

                        docker tag $ECR_REGISTRY/petclinic/spring-petclinic-cloud-vets-service:latest $REPOSITORY_PREFIX/vets-service:staging-1.0.$BUILD_NUMBER

                        docker tag $ECR_REGISTRY/petclinic/spring-petclinic-cloud-visits-service:latest $REPOSITORY_PREFIX/visits-service:staging-1.0.$BUILD_NUMBER
                    '''
                }
            }
        }
        stage("Push Images to ECR") {
            steps {
                script {
                    sh '''
                        # Push the tagged images to ECR
                        docker push $REPOSITORY_PREFIX/api-gateway:staging-1.0.$BUILD_NUMBER
                        docker push $REPOSITORY_PREFIX/customers-service:staging-1.0.$BUILD_NUMBER
                        docker push $REPOSITORY_PREFIX/vets-service:staging-1.0.$BUILD_NUMBER
                        docker push $REPOSITORY_PREFIX/visits-service:staging-1.0.$BUILD_NUMBER

                        echo 'Images tagged and pushed to ECR successfully.'

                        # Clean up local Docker images
                        docker image prune -af
                    '''
                }
            }
        }

        stage('Trigger ManifestUpdate') {
            steps {
                script {
                    echo "Triggering the Update Manifest Job"
                    build job: 'Update Manifest Staging', parameters: [string(name: 'DOCKERTAG', value: "staging-1.0.${env.BUILD_NUMBER}")]
                }
            }
        }
    }
}