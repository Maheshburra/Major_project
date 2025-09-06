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
                                // Convert Jenkins Windows workspace path to Linux/WSL format
                                def winPath = env.WORKSPACE
                                def linuxPath = winPath.replaceAll('C:', '/c').replaceAll('\\\\', '/')

                                docker.image("python:${PYTHON_VERSION}").inside(
                                    "-v ${linuxPath}:/workspace -w /workspace"
                                ) {
                                    sh 'python --version'
                                    sh 'pip install -r requirements.txt || echo "No requirements.txt"'
                                }
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

                    sh "docker build -t major_project:latest ${linuxPath}"
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
