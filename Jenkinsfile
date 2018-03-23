pipeline {

  parameters {
    string(name: 'AppName', defaultValue: 'mobapp', description: 'What application are we going to deploy today?')
    string(name: 'EnvName', defaultValue: 'dev', description: 'What environment are we deploying?')
    string(name: 'S3Bucket', defaultValue: 'mobapp-jenkins-artifacts', description: 'What S3 Bucket should be used to store/fetch application artifacts?')
  }

  agent mgmt-slave

  stages {

    stage('Build') {
      steps {
        echo '--------------------------------------'
        echo 'Building'
        echo '--------------------------------------'
        sh "mkdir -p output"
        # Write an useful file, which is needed to be archived.
        echo "This file is useful, need to archive it." > output/usefulfile.txt"
        echo "This file is useless, no need to archive it." > output/usefulfile.md"
      }
    }

    stage('Create Archive') {
      steps {
        echo '--------------------------------------'
        echo "Creating zip ..."
        echo '--------------------------------------'
        zip archive: true, dir: '', glob: 'output/*txt', zipFile: 'FancyArtifact.zip'
      }
    }

    stage('Push to S3') {
      steps {
        echo '--------------------------------------'
        echo "Upload to S3"
        echo '--------------------------------------'
        withAWS() {
          s3Upload(file:"FancyArtifact.zip", bucket:"test-mgm-artifact-bucket", path:"FancyArtifact.zip")
        }
      }
    }
  }
}
