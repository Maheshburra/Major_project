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
                    sh 'terraform init'
                }
            }
        }

        stage('Clean Up Existing Containers') {
            steps {
                // Clean up conflicting containers before applying new ones
                sh '''
                docker rm -f app_instance1 || true
                docker rm -f app_instance2 || true
                docker rm -f app_instance3 || true
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Verify Running Containers') {
            steps {
                sh 'docker ps --filter "name=app_instance"'
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
