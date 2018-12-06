pipeline {
    agent any
    environment {
        IMAGE='liatrio/zap'
        TAG='0.1.0'
    }
    stages {
        stage('Build container') {
            steps {
                sh "docker build -t ${env.IMAGE}:${TAG} ."
            }
        }
        stage('Push to Artifactory') {
            steps {
                    sh "docker push ${env.IMAGE}:${TAG}"
            }
        }
    }
}
