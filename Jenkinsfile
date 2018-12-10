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
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUsername')]) {
                    sh "docker login -u ${env.dockerUsername} -p ${env.dockerPassword}"
                    sh "docker push ${env.IMAGE}:${TAG}"
                }
            }
        }
    }
}
