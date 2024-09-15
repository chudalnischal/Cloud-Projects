pipeline {
    agent { label 'jenkins' }

    environment {
        DOCKER_REGISTRY = "https://index.docker.io/v1/" // docker registry url
        DOCKER_PUSH = "my repo" // docker repos
        DOCKER_CREDENTIALS = "my-crediential" //  # user id of the dockerhub
        DOCKER_IMAGE_NAME = "nischalchudal/flask:1.5" // image name 
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out the repository"
                // Add git checkout step
                git branch: 'main', url: 'https://github.com/chudalnischal/Cloud-Projects.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image"
                    // Build Docker image using the Dockerfile in the repository root or specified path
                    docker.build("${DOCKER_IMAGE_NAME}", ".")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Pushing Docker image to Docker Hub"
                    // Login to Docker Hub and push the image
                    docker.withRegistry(DOCKER_REGISTRY, DOCKER_CREDENTIALS) {
                        docker.image("${DOCKER_IMAGE_NAME}").push()
                    }
                }
            }
        }
    }
}
