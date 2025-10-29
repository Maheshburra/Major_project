pipeline {
    agent any
    environment {
        TERRAFORM_DIR = "terraform"
        DOCKER_IMAGE = "major_project:latest"
        DOCKERHUB_REPO = "maheshburra1121/myapp:latest"
        PATH = "C:\\Program Files\\Git\\cmd;C:\\terraform;C:\\Program Files\\Docker\\Docker\\resources\\bin;${env.PATH}"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🚀 Building Docker Image..."
                    dir("${env.WORKSPACE}") {
                        bat "docker build -t ${env.DOCKER_IMAGE} ."
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "📦 Pushing Docker image to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat """
                        docker login -u %DOCKER_USER% -p %DOCKER_PASS%
                        docker tag ${env.DOCKER_IMAGE} ${env.DOCKERHUB_REPO}
                        docker push ${env.DOCKERHUB_REPO}
                        """
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([string(credentialsId: 'TERRAFORM_CLOUD_TOKEN', variable: 'TF_TOKEN_app_terraform_io')]) {
                    dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                        bat "terraform init"
                    }
                }
            }
        }

        stage('Deploy Containers in Parallel') {
            parallel {
                stage('Container 1') {
                    steps {
                        withCredentials([string(credentialsId: 'TERRAFORM_CLOUD_TOKEN', variable: 'TF_TOKEN_app_terraform_io')]) {
                            dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                                bat "terraform apply -target=docker_container.app_instance1 -auto-approve"
                            }
                        }
                    }
                }
                stage('Container 2') {
                    steps {
                        withCredentials([string(credentialsId: 'TERRAFORM_CLOUD_TOKEN', variable: 'TF_TOKEN_app_terraform_io')]) {
                            dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                                bat "terraform apply -target=docker_container.app_instance2 -auto-approve"
                            }
                        }
                    }
                }
                stage('Container 3') {
                    steps {
                        withCredentials([string(credentialsId: 'TERRAFORM_CLOUD_TOKEN', variable: 'TF_TOKEN_app_terraform_io')]) {
                            dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                                bat "terraform apply -target=docker_container.app_instance3 -auto-approve"
                            }
                        }
                    }
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
