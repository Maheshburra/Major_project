pipeline {
    agent any
    environment {
        TERRAFORM_DIR = "terraform"
        DOCKER_IMAGE = "major_project:latest"
        PATH = "C:\\Program Files\\Git\\cmd;C:\\terraform;C:\\Program Files\\Docker\\Docker\\resources\\bin;${env.PATH}"
    }

    stages {
        // ----------------------
        // Stage 1: Build Docker
        // ----------------------
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
        // Stage 3: Deploy Containers in Parallel (Safe)
        // ---------------------------------------------
        stage('Deploy Containers in Parallel') {
            parallel {
                stage('Container 1') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            // Clone state file to avoid locking conflict
                            bat """
                            copy terraform.tfstate terraform1.tfstate >nul 2>&1
                            terraform apply -state=terraform1.tfstate -target=docker_container.app_instance1 -auto-approve -lock=false
                            """
                        }
                    }
                }
                stage('Container 2') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat """
                            copy terraform.tfstate terraform2.tfstate >nul 2>&1
                            terraform apply -state=terraform2.tfstate -target=docker_container.app_instance2 -auto-approve -lock=false
                            """
                        }
                    }
                }
                stage('Container 3') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat """
                            copy terraform.tfstate terraform3.tfstate >nul 2>&1
                            terraform apply -state=terraform3.tfstate -target=docker_container.app_instance3 -auto-approve -lock=false
                            """
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
            dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                bat 'del terraform1.tfstate terraform2.tfstate terraform3.tfstate 2>nul || exit 0'
            }
        }
        failure {
            echo "❌ Deployment failed. Check the logs for errors."
        }
    }
}
