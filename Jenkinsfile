pipeline {

  agent any

  triggers {
    issueCommentTrigger('.*build this please.*')
  }

  environment {
    SLACK_CHANNEL = '#opensource-cicd'
    DOCKER_REGISTRY = 'docker.io'
  }

  stages {

    stage ('Start') {
      steps {
        cancelPreviousBuilds()
        sendNotifications('STARTED', SLACK_CHANNEL)
      }
    }

    stage ('Building Docker Images') {
      steps {
        container('builder') {
          script {
            sh 'make image'
          }
        }
      }
    }

    stage ('Pushing Docker Images') {
      when {
        anyOf {
          branch 'website'
        }
      }
      steps {
        container('builder') {
          script {
            docker.withRegistry('https://docker.io', 'dockerhub-credentials') {
              sh 'make push-image'
            }
          }
        }
      }
    }
  }

  post {
    success {
      sendNotifications('SUCCESS', SLACK_CHANNEL)
    }
    failure {
      sendNotifications('FAILED', SLACK_CHANNEL)
    }
  }
}
