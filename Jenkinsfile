pipeline {
  agent {
    docker {
      image 'hashicorp/terraform:latest'
      args '-i --entrypoint='
    }
  }

  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
  }

  stages {
    stage('terraform init') {
      steps {
        withAWS(credentials: 'terraform_user', region: env.AWS_DEFAULT_REGION) {
          sh 'terraform init'
        }
      }
    }

    stage('terraform plan') {
      steps {
        withAWS(credentials: 'terraform_user', region: env.AWS_DEFAULT_REGION) {
          sh 'terraform plan -out=tfplan -input=false'
        }
      }
    }

    stage('terraform apply') {
      steps {
        input 'Deploy Infrastructure?'
        withAWS(credentials: 'terraform_user', region: env.AWS_DEFAULT_REGION) {
          sh 'terraform apply tfplan'
        }
      }
    }

    stage('terraform destroy') {
      steps {
        input 'Destroy Infrastructure?'
        withAWS(credentials: 'terraform_user', region: env.AWS_DEFAULT_REGION) {
          sh 'terraform destroy -auto-approve'
        }
      }
    }
  }
}
