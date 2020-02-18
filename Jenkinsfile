
library identifier: "pipeline-library@v1.5",
retriever: modernSCM(
  [
    $class: "GitSCMSource",
    remote: "https://github.com/redhat-cop/pipeline-library.git"
  ]
)

openshift.withCluster() {

  env.NAMESPACE = openshift.project()
  env.APP_NAME = "open-suite-webapp"
  env.BUILD = "${env.NAMESPACE}"
  env.DEV = env.BUILD.replace('labs-ci-cd', 'dev')
  env.TEST = env.BUILD.replace('labs-ci-cd', 'test')

  echo "Starting Pipeline for ${APP_NAME}..."

}

pipeline {
  agent {
    label 'jenkins-slave-gradle'
  }

  stages {
    stage('Build') {
      steps {
        sh "docker build -t jenkins-slave-gradle"
      }
    }

    stage('Bake'){
      steps {
        binaryBuild(projectName: env.BUILD, buildConfigName: env.APP_NAME, buildFromPath: "target/")
      }
    }

    stage('Sync changes to Dev'){
      agent { label 'jenkins-slave-argocd' }
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'honda-labs-ci-cd-argo-auth', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]){
            sh 'argocd login argo-cd-argocd-server-honda-labs-ci-cd.apps.honda-lde.rht-labs.com:443 --grpc-web --config /tmp/.argo --username $USERNAME --password $PASSWORD'
            sh 'argocd app sync ${APP_NAME}-dev --config /tmp/.argo'
        }
      }
    }

    stage('Deploy to Dev'){
      steps {
        tagImage(sourceImageName: env.APP_NAME, sourceImagePath: env.BUILD, toImagePath: env.DEV)
      }
    }
  }
}
