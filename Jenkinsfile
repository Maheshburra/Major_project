pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "maheshburra/django-app"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            parallel {
                stage('Python 3.10') {
                    agent { docker { image 'python:3.10' } }
                    steps {
                        sh 'pip install -r requirements.txt'
                        sh 'python manage.py test'
                    }
                }
                stage('Python 3.11') {
                    agent { docker { image 'python:3.11' } }
                    steps {
                        sh 'pip install -r requirements.txt'
                        sh 'python manage.py test'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
}
