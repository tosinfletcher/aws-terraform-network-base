pipeline {
  parameters {
    string(name: 'BRANCH', defaultValue: 'master', description: 'Branch to Build')
  }

  agent { dockerfile true}

  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
    AWS_CREDENTIALS = 'aws_cred'
  }

  stages {
    stage('Terraform init & fmt') {
      steps {
        withAWS(credentials: env.AWS_CREDENTIALS, region: env.AWS_DEFAULT_REGION) {
          sh 'terraform init; terraform fmt'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withAWS(credentials: env.AWS_CREDENTIALS, region: env.AWS_DEFAULT_REGION) {
          sh 'terraform plan -out=tfplan -input=false'
        }
      }
    }

    stage('Deploying Network Infrastructure') {
      steps {
        withAWS(credentials: env.AWS_CREDENTIALS, region: env.AWS_DEFAULT_REGION) {
          sh 'terraform apply tfplan'
        }
      }
    }
  }
}
