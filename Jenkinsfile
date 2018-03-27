// This shows a simple example of how to archive the build output artifacts.

def artifact_name = 'artifact.zip'

node('mgmt-slave') {
    stage "Create build output"

    // Make the output directory.
    sh "mkdir -p output"

    // Write an useful file, which is needed to be archived.
    writeFile file: "output/usefulfile.txt", text: "This file is useful, need to archive it."

    // Write an useless file, which is not needed to be archived.
    writeFile file: "output/uselessfile.md", text: "This file is useless, no need to archive it."

    stage "Archive build output"

    // Archive the build output artifacts.
    // archiveArtifacts artifacts: 'output/*.txt', excludes: 'output/*.md'
    zip archive: true, glob: '*.txt', zipFile: artifact_name

    stage "Upload Artifact to s3"
    s3Upload acl: 'Private', bucket: 'knab-artifact-bucket-mgmt', path: 'test1/' + artifact_name , file: artifact_name
}
