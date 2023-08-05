pipeline {
    agent any
    environment {
        LOCAL_IMAGE_NAME = "develeap"
        AWS_REGION = "eu-central-1"
        ECR_REPO_NAME  = "public.ecr.aws/x0v9s0q7/vladimir_public"
        VERSION = "1.0.5"
    }
    stages {

        stage('Building image') {
            steps{
                sh 'docker build -t ${LOCAL_IMAGE_NAME} .'
            }
        }

        stage('Push Image to ECR') {
            steps{
                withAWS(credentials: 'aws_credentials', region: AWS_REGION){
                    script {
                        sh """
                        aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x0v9s0q7
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

