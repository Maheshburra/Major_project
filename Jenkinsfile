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
                    // Use Windows path directly for Docker build
                    bat "docker build -t major_project:latest \"${winPath}\""
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
