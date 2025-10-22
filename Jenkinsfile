pipeline {
    agent any

    environment {
        IMAGE_NAME = "major_project:latest"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                }
            }
        }

        stage('Clean Up Existing Containers') {
            steps {
                bat '''
                docker rm -f app_instance1 || exit 0
                docker rm -f app_instance2 || exit 0
                docker rm -f app_instance3 || exit 0
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    bat 'terraform apply -auto-approve'
                }
            }
        }

        stage('Verify Running Containers') {
            steps {
                bat 'docker ps -a'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Deployment failed. Please check the logs above.'
        }
        always {
            echo '📦 Pipeline execution completed.'
        }
    }
}
`
