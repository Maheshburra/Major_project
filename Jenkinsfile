pipeline {
    agent any
    environment {
        TERRAFORM_DIR = "terraform"
        DOCKER_IMAGE = "major_project:latest"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} ../'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Deploy Containers in Parallel') {
            parallel {
                stage('Container 1') {
                    steps {
                        dir("${env.TERRAFORM_DIR}") {
                            sh 'terraform apply -target=docker_container.app_instance1 -auto-approve'
                        }
                    }
                }
                stage('Container 2') {
                    steps {
                        dir("${env.TERRAFORM_DIR}") {
                            sh 'terraform apply -target=docker_container.app_instance2 -auto-approve'
                        }
                    }
                }
                stage('Container 3') {
                    steps {
                        dir("${env.TERRAFORM_DIR}") {
                            sh 'terraform apply -target=docker_container.app_instance3 -auto-approve'
                        }
                    }
                }
            }
        }
    }
}
