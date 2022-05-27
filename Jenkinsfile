#!/usr/bin/env groovy
pipeline {
  agent any
  environment {
    REGISTRY = 'gcr.io/lbg-090522'
    APP_NAME = 'lbg-api-app'
    TAG = 'peter'
  }
  stages {
    stage('Build image') {
      steps {
        sh 'docker rmi -f $(docker images -q) || true'
        sh 'docker build -t ${REGISTRY}/${APP_NAME}:${TAG}-${BUILD_ID} .'
        sh 'docker tag ${REGISTRY}/${APP_NAME}:${TAG}-${BUILD_ID} ${REGISTRY}/${APP_NAME}:${TAG}-latest'
      }
    }
    stage('Push image to DockerHub') {
      steps {
        sh 'docker push ${REGISTRY}/${APP_NAME}:${TAG}-${BUILD_ID}'
        sh 'docker push ${REGISTRY}/${APP_NAME}:${TAG}-latest'
      }
    }
    stage('Apply the kubernetes manifest yamls') {
      steps {
        sh 'kubectl apply -f kubernetes'
      }
    }
    stage('List pods, deployments and services') {
      steps {
        sh 'kubectl get pods'
        sh 'kubectl get deployments'
        sh 'kubectl get services'
      }
    }
    stage('Cleanup') {
      steps {
        sh 'docker system prune -f'
      }
    }
  }
  post {
    failure {
      echo 'Processing failed'
    }
    success {
      echo 'Processing succeeded'
    }
  }
}