pipeline {
  // ใช้ any agent เพื่อหลีกเลี่ยงปัญหา Docker path mounting บน windows
  stages {
    stage("build") {
      steps {
        echo 'Building the application...'
      }
    }
    stage("test") {
      steps {
        echo 'Testing the application...'
      }
    }
    stage("deploy") {
      steps {
        echo 'Deploying the application...'
      }
    }
  }
  post {
    
  }
}
