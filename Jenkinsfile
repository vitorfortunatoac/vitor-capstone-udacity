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
                     docker.image('hadolint/hadolint:latest-debian').inside() {
                             sh 'hadolint Dockerfile | tee -a hadolint.txt'
                             sh '''
                                 lintErrors=$(stat --printf="%s"  hadolint.txt)
                                 if [ "$lintErrors" -gt "0" ]; then
                                     echo "Errors linting Dockerfile"
                                     cat hadolint.txt
                                     exit 1
                                 else
                                     echo "Done linting Dockerfile"
                                 fi
                             '''
                     }
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
                    sh 'kubectl apply -f k8s/kubernets.yml'
                }
            }
        }
    }    
}