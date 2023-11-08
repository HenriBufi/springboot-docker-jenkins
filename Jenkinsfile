pipeline {
    agent any

    environment {
        COMMIT_HASH = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    git branch: 'main', credentialsId: 'docker', url: 'https://github.com/HenriBufi/springboot-docker-jenkins.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t henribufii/testing:$COMMIT_HASH ."
            }
        }

        stage('Test Image') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Push Image to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh "docker push henribufii/testing:$COMMIT_HASH"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f springboot-deployment.yaml'
            }
        }
    }
}
