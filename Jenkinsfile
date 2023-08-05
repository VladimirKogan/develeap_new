pipeline {
    agent any
    environment {
        LOCAL_IMAGE_NAME = "develeap"
        AWS_REGION = "eu-central-1"
        ECR_REPO_NAME  = "538535932316.dkr.ecr.eu-central-1.amazonaws.com/develeap"
        VERSION = "1.0.1"
    }
    stages {
        stage('Cloning Git') {
            steps {
                git 'https://github.com/VladimirKogan/develeap.git'
            }
        }

        stage('Building image') {
            steps{
                sh 'docker build -t ${LOCAL_IMAGE_NAME} .'
            }
        }

        stage('Push Image to ECR') {
            steps{
                withAWS(credentials: 'aws_credentials', region: AWS_REGION){
                    script {
                        def ecr_password = sh(returnStdout: true, script: "aws ecr get-login-password").trim()
                        sh """
                            set +x
                            docker login -u AWS -p ${ecr_password} ${ECR_REPO_NAME} && \
                            set -x
                        docker tag ${LOCAL_IMAGE_NAME}:latest ${ECR_REPO_NAME}:${VERSION}
                        docker push ${ECR_REPO_NAME}:${VERSION}
                        # tag with latest also
                        docker tag ${ECR_REPO_NAME}:${VERSION} ${ECR_REPO_NAME}:latest
                        docker push ${ECR_REPO_NAME}:latest
                        """

                    }
                }
            }
        }
    }
}

