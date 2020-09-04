pipeline {
    environment {
        eksClusterName = 'vitor-final-project-cluster'
        eksRegion = 'eu-central-1'
        dockerHub = 'vitorfortunatoac'
        dockerImage = 'vitor-udacity-docker-capstonedocker'
    }
    agent any
    stages {
        stage('Lint Dockerfile') {
            steps {
                script {
                    sh '''docker run --rm -i hadolint/hadolint < Dockerfile'''
                    sh 'tidy -q -e app/*.html'
                }
            }
        }
        stage('Docker build and Push') {
            steps {
                script {
                    dockerImage = docker.build('${dockerHub}/${dockerImage}')
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credential') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Apply deployment') {
            steps {  
                withAWS(credentials: '249345434414', region: eksRegion) {
                    sh "aws eks --region eu-central-1 update-kubeconfig --name vitor-final-project-cluster"
                    sh 'kubectl apply -f k8s/kubernets.yml'
                }
            }
        }

        stage('Update deployment') {
            steps {
                withAWS(credentials: '249345434414', region: eksRegion) {
                    sh "kubectl set image deployment.apps/vitor-final-project vitor-final-project=vitorfortunatoac/vitor-udacity-docker-capstonedocker:${BUILD_NUMBER}"
                    sh "kubectl get pods"
                    sh "kubectl get svc"
                }
            }
        }
    }    
}