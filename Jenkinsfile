pipeline {
    environment {
        eksClusterName = 'vitor-final-project-cluster'
        eksRegion = 'us-central-1'
        dockerHub = 'vitorfortunatoac'
        dockerImage = 'vitor-udacity-docker-capstonedocker'
    }
    agent any
    stages {
        stage('Lint') {
            steps {
                sh 'tidy -q -e **/*.html'
                sh '''docker run --rm -i hadolint/hadolint < Dockerfile'''
            }
        }
        stage('Docker build') {
            steps {
                script {
                    dockerImage = docker.build('${dockerHub}/${dockerImage}')
                    docker.withRegistry('', 'docker-hub-creds') {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('K8S Deploy')  {
            steps {
                withAWS(credentials: 'aws-credentials', region: eksRegion) {
                    sh 'aws eks --region=${eksRegion} update-kubeconfig --name ${eksClusterName}'
                    sh 'kubectl apply -f k8s/uc-capstone-deployment.yml'
                }
            }
        }
    }
}