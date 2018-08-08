pipeline {
  agent any
  environment {
    // Application-specific arguments
    STACK = 'ins_csp'
  }

  stages {
    stage('First step') {
      steps {
        echo "Dummy"
        echo "variable "
      }
    }
    stage('second step') {
      steps {
        // Load all variables set in the version file
        load ".env.test"
        echo "Container version: ${BUILD_NUMBER}"
      }
    }
    stage('approve') {
      steps {
        timeout(time: 7, unit: 'DAYS') {
          input message: 'Do you want to deploy?', submitter: 'ops'
        }
      }
    }
    stage('third step') {
      steps {
        echo "Dummy"
        echo "variable dus=${dus}"
      }
    }


  }

}
