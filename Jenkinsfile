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

        stage('Docker Build & Deploy') {
            steps {
                script {
                    def winPath = env.WORKSPACE
                    // Build Docker image
                    bat "docker build -t major_project:latest \"${winPath}\""

                    // Stop & remove old containers safely
                    bat """
                    docker stop major_project_container || echo 'No container running'
                    docker rm major_project_container || echo 'No container to remove'
                    """

                    // Deploy new container
                    bat "docker run -d -p 8000:8000 --name major_project_container major_project:latest"
                }
            }
        }
    }
}
