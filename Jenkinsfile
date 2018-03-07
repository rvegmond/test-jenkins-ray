pipeline {
    agent {
	{ label 'ecs' }
        docker { 
	   image 'node:7-alpine'
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
