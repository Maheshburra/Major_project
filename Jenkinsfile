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
                script {
                    echo "🚀 Building Docker Image..."
                    dir("${env.WORKSPACE}") {
                        bat "docker build -t ${env.DOCKER_IMAGE} ."
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                    bat "terraform init -input=false"
                }
            }
        }

        stage('Deploy Containers in Parallel') {
            parallel {
                stage('Container 1') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance1 -auto-approve -input=false"
                        }
                    }
                }
                stage('Container 2') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance2 -auto-approve -input=false"
                        }
                    }
                }
                stage('Container 3') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance3 -auto-approve -input=false"
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
            echo "✅ Deployment succeeded! Containers are running on ports 8001, 8002, and 8003."
        }
        failure {
            echo "❌ Deployment failed. Check the logs for errors."
        }
    }
}
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
                script {
                    echo "🚀 Building Docker Image..."
                    dir("${env.WORKSPACE}") {
                        bat "docker build -t ${env.DOCKER_IMAGE} ."
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                    bat "terraform init -input=false"
                }
            }
        }

        stage('Deploy Containers in Parallel') {
            parallel {
                stage('Container 1') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance1 -auto-approve -input=false"
                        }
                    }
                }
                stage('Container 2') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance2 -auto-approve -input=false"
                        }
                    }
                }
                stage('Container 3') {
                    steps {
                        dir("${env.WORKSPACE}\\${env.TERRAFORM_DIR}") {
                            bat "terraform apply -target=docker_container.app_instance3 -auto-approve -input=false"
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
            echo "✅ Deployment succeeded! Containers are running on ports 8001, 8002, and 8003."
        }
        failure {
            echo "❌ Deployment failed. Check the logs for errors."
        }
    }
}
