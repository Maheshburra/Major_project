pipeline {
    agent any

    stages {
        stage('Python Matrix Build') {
            matrix {
                axes {
                    axis {
                        name 'PYTHON_VERSION'
                        values '3.10', '3.11'
                    }
                }
                stages {
                    stage('Run inside Docker') {
                        steps {
                            script {
                                def winPath = env.WORKSPACE
                                def linuxPath = winPath.replaceAll('C:', '/c').replaceAll('\\\\', '/')

                                bat """
                                    docker run --rm -v ${linuxPath}:/workspace -w /workspace ^
                                    python:${PYTHON_VERSION} sh -c "python --version && if [ -f requirements.txt ]; then pip install -r requirements.txt; else echo 'No requirements.txt found'; fi"
                                """
                            }
                        }
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    def winPath = env.WORKSPACE
                    bat "docker build -t major_project:latest \"${winPath}\""
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Replace with your Docker Hub username
                    def dockerUser = "your-dockerhub-username"

                    bat "docker tag major_project:latest ${dockerUser}/myapp:latest"
                    bat "docker push ${dockerUser}/myapp:latest"
                }
            }
        }

        stage('Parallel Deploy') {
            parallel {
                stage('Deploy App v1') {
                    steps {
                        bat """
                        docker stop app_v1 || echo 'No container running'
                        docker rm app_v1 || echo 'No container to remove'
                        docker run -d -p 8000:8000 --name app_v1 major_project:latest
                        """
                    }
                }
                stage('Deploy App v2') {
                    steps {
                        bat """
                        docker stop app_v2 || echo 'No container running'
                        docker rm app_v2 || echo 'No container to remove'
                        docker run -d -p 8001:8000 --name app_v2 major_project:latest
                        """
                    }
                }
            }
        }
    }
}
