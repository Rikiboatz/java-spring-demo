pipeline {
  // ใช้ any agent เพื่อหลีกเลี่ยงปัญหา Docker path mounting บน windows
  agent any
  
  stages{
    stage("build"){
      steps {
        echo 'Building the application...'
      }
    }
    stage("test"){
      steps {
        echo 'Testing the application...'
      }
    }
    stage("deploy"){
      steps{
        echo 'Deploying the application...'
      }
    }
  }
  post {
    success{
      bat 'echo "Build application successful"'
    }
    failure{
      bat 'echo "Build application failed"'
    }
  }
}
