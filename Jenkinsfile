pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            parallel {
                stage('Python 3.10') {
                    agent {
                        docker {
                            image 'python:3.10'
                            // convert Windows C:\... to /c/... for Docker
                            args '-v /c/ProgramData/Jenkins/.jenkins/workspace/Major_Project:/workspace -w /workspace'
                        }
                    }
                    steps {
                        sh 'python --version'
                        sh 'pip install -r requirements.txt || true'
                    }
                }
                stage('Python 3.11') {
                    agent {
                        docker {
                            image 'python:3.11'
                            args '-v /c/ProgramData/Jenkins/.jenkins/workspace/Major_Project:/workspace -w /workspace'
                        }
                    }
                    steps {
                        sh 'python --version'
                        sh 'pip install -r requirements.txt || true'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t major_project:latest .'
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploy stage (add your deployment commands here)"
            }
        }
    }
}
