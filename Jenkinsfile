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
        echo "variable dus=${dus}"
      }
    }
    stage('third step') {
      steps {
        echo "Dummy"
        echo "variable dus=${dus}"
      }
    }

    stage('second step') {
      steps {
        // Load all variables set in the version file
        load ".env.test"
        echo "Container version: ${BUILD_NUMBER}"
      }
    }
  }

}
