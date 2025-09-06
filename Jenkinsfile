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
                                // Convert Windows path (C:\...) to Git Bash/Docker-friendly path (/c/...)
                                def winPath = env.WORKSPACE
                                def linuxPath = winPath.replaceAll('C:', '/c').replaceAll('\\\\', '/')

                                // Run inside Python Docker container
                                bat """
                                    docker run --rm -v ${linuxPath}:/workspace -w /workspace ^
                                    python:${PYTHON_VERSION} sh -c "python --version && pip install -r requirements.txt || echo 'No requirements.txt'"
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
                    def linuxPath = winPath.replaceAll('C:', '/c').replaceAll('\\\\', '/')

                    bat "docker build -t major_project:latest ${linuxPath}"
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deployment step (to be configured)"
            }
        }
    }
}
