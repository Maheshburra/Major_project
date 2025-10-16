pipeline {
    agent any
    environment {
        TERRAFORM_DIR = "terraform"
        DOCKER_IMAGE = "major_project:latest"
    }
    stages {

        // ----------------------
        // Stage 1: Build Docker
        // ----------------------
        stage('Build Docker Image') {
            steps {
                script {
                    echo "🚀 Building Docker Image..."
                    // Enter the Jenkins workspace to ensure Dockerfile is found
                    dir("${env.WORKSPACE}") {
                        bat "docker build -t ${env.DOCKER_IMAGE} ."
                    }
                }
            }
        }

        // ----------------------
        // Stage 2: Terraform Init
        // ----------------------
        stage('Terraform Init') {
            steps {
                dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                    bat "terraform init"
                }
            }
        }

        // ---------------------------------------------
        // Stage 3: Deploy Containers in Parallel
        // ---------------------------------------------
        stage('Deploy Containers in Parallel') {
            parallel {
                stage('Container 1') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance1 -auto-approve"
                        }
                    }
                }
                stage('Container 2') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance2 -auto-approve"
                        }
                    }
                }
                stage('Container 3') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance3 -auto-approve"
                        }
                    }
                }
            }
        }
    }

    // ----------------------
    // Post Actions
    // ----------------------
    post {
        always {
            echo "🧹 Cleaning up temporary files..."
        }
        failure {
            echo "❌ Deployment failed. Check the logs for errors."
        }
    }
}
