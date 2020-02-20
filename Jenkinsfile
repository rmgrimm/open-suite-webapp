
library identifier: "pipeline-library@v1.5",
retriever: modernSCM(
  [
    $class: "GitSCMSource",
    remote: "https://github.com/redhat-cop/pipeline-library.git"
  ]
)

openshift.withCluster() {

  env.NAMESPACE = openshift.project()
  env.APP_NAME = "${env.APP_NAME}"
  env.BUILD = "${env.NAMESPACE}"
  env.DEV = "${env.DEV}"
  env.TEST = "${env.TEST}"

  echo "Starting Pipeline for ${APP_NAME}..."

}

pipeline {
  agent {
    label 'jenkins-slave-gradle'
  }

  stages {
    stage('Build') {
      steps {
        sh "./gradlew build"
      }
    }

    stage('Bake'){
      steps {
        binaryBuild(projectName: env.BUILD, buildConfigName: env.APP_NAME, buildFromPath: "build/")
      }
    }

    stage('Sync changes to Dev'){
      agent { label 'jenkins-slave-gradle' }
      steps {
	  sh 'cd charts/${APP_NAME} && helm template . -f deploy-dev-values.yaml | oc apply -n ${DEV} -f -'
        }
      }


    stage('Deploy to Dev'){
      steps {
        tagImage(sourceImageName: env.APP_NAME, sourceImagePath: env.BUILD, toImagePath: env.DEV)
      }
    }
  }
}

