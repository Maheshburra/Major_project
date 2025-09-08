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

        stage('Deploy') {
            steps {
                script {
                    bat """
                        docker stop major_project_container || echo "No container running"
                        docker rm major_project_container || echo "No container to remove"
                        docker run -d -p 8000:8000 --name major_project_container major_project:latest
                    """
                }
            }
        }

        stage('Deploy in Parallel (Showcase)') {
            parallel {
                stage('Deploy Version A') {
                    steps {
                        script {
                            bat """
                                docker stop app_v1 || echo "Not running"
                                docker rm app_v1 || echo "Not exist"
                                docker run -d -p 8001:8000 --name app_v1 major_project:latest
                            """
                        }
                    }
                }
                stage('Deploy Version B') {
                    steps {
                        script {
                            bat """
                                docker stop app_v2 || echo "Not running"
                                docker rm app_v2 || echo "Not exist"
                                docker run -d -p 8002:8000 --name app_v2 major_project:latest
                            """
                        }
                    }
                }
            }
        }
    }
}
