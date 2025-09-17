pipeline {
    agent any

    environment {
        TERRAFORM_DIR = "terraform"
        DOCKER_IMAGE  = "major_project:latest"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "🚀 Building Docker Image..."
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    script {
                        echo "⚙️ Initializing Terraform..."
                        sh "terraform init -input=false"
                    }
                }
            }
        }

        stage('Deploy Containers in Parallel') {
            parallel {
                stage('Container 1') {
                    steps {
                        dir("${TERRAFORM_DIR}") {
                            script {
                                echo "🐳 Deploying app_instance1..."
                                sh "terraform apply -target=docker_container.app_instance1 -auto-approve -input=false"
                            }
                        }
                    }
                }
                stage('Container 2') {
                    steps {
                        dir("${TERRAFORM_DIR}") {
                            script {
                                echo "🐳 Deploying app_instance2..."
                                sh "terraform apply -target=docker_container.app_instance2 -auto-approve -input=false"
                            }
                        }
                    }
                }
                stage('Container 3') {
                    steps {
                        dir("${TERRAFORM_DIR}") {
                            script {
                                echo "🐳 Deploying app_instance3..."
                                sh "terraform apply -target=docker_container.app_instance3 -auto-approve -input=false"
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
        success {
            echo "✅ All containers deployed successfully in parallel!"
        }
        failure {
            echo "❌ Deployment failed. Check the logs for errors."
        }
    }
}
