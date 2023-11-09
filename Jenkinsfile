pipeline {
    agent any

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
                sh "docker build -t henribufii/jenkins:latest ."
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
                    sh "docker push henribufii/jenkins:latest"
                }
            }
        }

        // stage('Deploy to Kubernetes') {
        //     steps {
        //         sh 'kubectl apply -f springboot-deployment.yaml'
        //         sh 'kubectl apply -f ingress.yaml'
        //     }
        // }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    try {
                        sh 'kubectl apply -f springboot-deployment.yaml'
                    } catch (Exception e) {
                        echo "Deployment failed. Rolling back..."
                        sh 'kubectl rollout undo deployment/springboot-app'
                        error "Rollback completed due to deployment failure."
                    }
                }
            }
        }

        stage('Deployment Verification') {
            steps {
                sh 'kubectl rollout status deployment/springboot-app'
            }
        }
    }
}
