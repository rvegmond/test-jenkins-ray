pipeline {
    agent {
        docker { 
	   image 'node:7-alpine'
	   label 'ecs' 
        }
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}
