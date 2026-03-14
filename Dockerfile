# pipeline{
#     agent any

#      enviroment{

# CONSTANER_NAME="nest-app"
# IMAGE_NAME="nest-image"
# EMAIL="satyaprakashsinghkasia@gmail.com"
# PORT=4000
        
#     }
#     stages {
#         stage('clone repo'){
#             steps{
#                 git branch:'main', url:'https://github.com/SatyaSDE-1/docker-cicd.git'
#             }
#         }
#         stage('Build docker image'){
#             stages{
#                 steps{
#                     sh 'docker build -t $IMAGE_NAME'
#                 }
#             }
#         }
#         stage('stop and remove previous container'){
#             stages{
#                 steps{
#                      sh '''
#                      docker stop $CONSTANER_NAME || true
#                      docker remove $CONSTANER_NAME
#                         '''
#                 }
#             }
#         }
#         stage('docker container run'){
#             stages{
#                 steps{
#                      sh '''
#                      docker -d -p ${PORT}:${PORT}
#                      --name $CONSTANER_NAME $IMAGE_NAME
#                         '''
#                 }
#             }
#         }
#         stage('SEND EMAIL NOTIFICATION'){
#             stages{
#                 steps{
#                     emailtext{
#                         subject: "Nest app deployemtnsuceefully"
#                         body:"your nest app deply"
#                         to :`${EMAIL}`
#                     }
#                 }
#             }
#         } 
#     }
# }



pipeline {
    agent any

    environment {
        CONTAINER_NAME = "nest-app"
        IMAGE_NAME = "nest-image"
        EMAIL = "satyaprakashsinghkasia@gmail.com"
        PORT = "4000"
    }

    stages {

        stage('Clone Repository') {
            steps {
                echo "Cloning repository..."
                git branch: 'main', url: 'https://github.com/SatyaSDE-1/docker-cicd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Stop and Remove Previous Container') {
            steps {
                echo "Stopping and removing old container if exists..."
                sh """
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Running Docker container..."
                sh "docker run -d -p ${PORT}:${PORT} --name $CONTAINER_NAME $IMAGE_NAME"
            }
        }

    }

    post {
        failure {
            emailext(
                subject: "NestJS App Deployment Failed ❌",
                body: "Deployment failed! Please check Jenkins logs.",
                to: "${EMAIL}"
            )
        }
    }
}