pipeline {
    agent any

    environment {
        OLD_CONTAINER = "nest-app"
        NEW_CONTAINER = "nest-app-new"
        IMAGE_NAME = "nest-image"
        PORT = "4000"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/SatyaSDE-1/docker-cicd.git'
            }
        }

        stage('Build Image') {
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Run New Container') {
            steps {
                sh """
                docker rm -f $NEW_CONTAINER || true
                docker run -d -p ${PORT}:${PORT} --name $NEW_CONTAINER $IMAGE_NAME
                """
            }
        }

        stage('Health Check') {
            steps {
                sh "sleep 10"
                sh "docker ps | grep $NEW_CONTAINER"
            }
        }

        stage('Switch Containers') {
            steps {
                sh """
                docker stop $OLD_CONTAINER || true
                docker rm $OLD_CONTAINER || true
                docker rename $NEW_CONTAINER $OLD_CONTAINER
                """
            }
        }
    }
}
