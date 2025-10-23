pipeline {
    agent any
    environment {
        TERRAFORM_DIR = "terraform"
        DOCKER_IMAGE = "major_project:latest"
        PATH = "C:\\Program Files\\Git\\cmd;C:\\terraform;C:\\Program Files\\Docker\\Docker\\resources\\bin;${env.PATH}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                dir("${env.WORKSPACE}") {
                    bat "docker build -t ${env.DOCKER_IMAGE} ."
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                    bat "terraform init"
                }
            }
        }

        stage('Clean Old Containers') {
            steps {
                bat '''
                docker rm -f app_instance1 || exit /b 0
                docker rm -f app_instance2 || exit /b 0
                docker rm -f app_instance3 || exit /b 0
                '''
            }
        }

        stage('Deploy Containers') {
            steps {
                dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                    bat "terraform apply -auto-approve"
                }
            }
        }
    }

    post {
        always {
            echo "🧹 Cleaning up temporary files..."
        }
        failure {
            echo "❌ Deployment failed. Check the logs for errors."
        }
    }
}
