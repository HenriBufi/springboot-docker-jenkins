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
                sh 'docker build -t henribufii/testing:latest .'
            }
        }

        // stage('Test Image') {
        //     steps {
        //         sh 'docker run myapp:latest /app/test.sh'
        //     }
        // }

        stage('Push Image to Registry') {
            steps {
                sh "docker login -u henribfuii -p henri23H"
                sh 'docker push henribufii/testing:latest'
            }
        }

        // stage('Deploy to Kubernetes') {
        //     steps {
        //         sh 'kubectl apply -f k8s-deployment.yaml'
        //     }
        // }
    }
}
