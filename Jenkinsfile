pipeline {
    agent any

    environment {
        TERRAFORM_DIR = "terraform"
        DOCKER_IMAGE = "major_project:latest"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image..."
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    echo "Initializing Terraform..."
                    sh 'terraform init'
                }
            }
        }

        stage('Deploy Containers in Parallel') {
            parallel {

                stage('Container 1') {
                    steps {
                        dir("${env.TERRAFORM_DIR}") {
                            echo "Deploying Container 1..."
                            sh 'docker rm -f app_instance1 || true'
                            sh 'terraform apply -target=docker_container.app_instance1 -auto-approve'
                        }
                    }
                }

                stage('Container 2') {
                    steps {
                        dir("${env.TERRAFORM_DIR}") {
                            echo "Deploying Container 2..."
                            sh 'docker rm -f app_instance2 || true'
                            sh 'terraform apply -target=docker_container.app_instance2 -auto-approve'
                        }
                    }
                }

                stage('Container 3') {
                    steps {
                        dir("${env.TERRAFORM_DIR}") {
                            echo "Deploying Container 3..."
                            sh 'docker rm -f app_instance3 || true'
                            sh 'terraform apply -target=docker_container.app_instance3 -auto-approve'
                        }
                    }
                }
            }
        }

        stage('Phase 2 Verification') {
            steps {
                echo "Verifying containers..."
                sh 'docker ps'
                sh 'docker logs app_instance1 || true'
                sh 'docker logs app_instance2 || true'
                sh 'docker logs app_instance3 || true'
            }
        }
    }
}
