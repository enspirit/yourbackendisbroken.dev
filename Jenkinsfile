pipeline {

  agent any

  environment {
    DOCKER_REGISTRY = 'q8s.quadrabee.com'
  }

  stages {

    stage ('Building Docker Image') {
      steps {
        container('builder') {
          sh 'make image'
        }
      }
    }

    stage ('Pushing Docker Image') {
      when {
        anyOf {
          branch 'master'
        }
      }
      steps {
        container('builder') {
          script {
            docker.withRegistry('https://q8s.quadrabee.com', 'q8s-deploy-enspirit-be') {
              sh 'make push-image'
            }
          }
        }
      }
    }
  }
}
