pipeline {
    agent any

    environment {
        TERRAFORM_DIR = "terraform"
        DOCKER_IMAGE  = "major_project:latest"
        // Add required tools to PATH for Jenkins agent
        PATH = "C:\\Program Files\\Git\\cmd;C:\\terraform;C:\\Program Files\\Docker\\Docker\\resources\\bin;${env.PATH}"
    }

    stages {

        // ----------------------
        // Stage 1: Build Docker Image
        // ----------------------
        stage('Build Docker Image') {
            steps {
                script {
                    echo "🚀 Building Docker Image..."
                    dir("${env.WORKSPACE}") {
                        // Build Docker image from Dockerfile in workspace
                        bat 'docker build -t %DOCKER_IMAGE% .'
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
                    // Initialize Terraform backend and providers
                    bat 'terraform init -upgrade'
                }
            }
        }

        // ----------------------
        // Stage 3: Terraform Validate & Plan (Optional but recommended)
        // ----------------------
        stage('Terraform Validate & Plan') {
            steps {
                dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                    bat '''
                    terraform validate
                    terraform plan -out=tfplan
                    '''
                }
            }
        }

        // ---------------------------------------------
        // Stage 4: Deploy Containers in Parallel
        // ---------------------------------------------
        stage('Deploy Containers in Parallel') {
            parallel {
                stage('Container 1') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat 'terraform apply -target=docker_container.app_instance1 -auto-approve'
                        }
                    }
                }
                stage('Container 2') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat 'terraform apply -target=docker_container.app_instance2 -auto-approve'
                        }
                    }
                }
                stage('Container 3') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat 'terraform apply -target=docker_container.app_instance3 -auto-approve'
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
        success {
            echo "✅ Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed. Check the logs for errors."
        }
    }
}
