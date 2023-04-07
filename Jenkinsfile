pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:latest'
            args '-v $HOME/.aws:/root/.aws -v $(pwd):/terraform'
        }
    }

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('terraform init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('terraform plan') {
            steps {
                sh 'terraform plan -out=tfplan -input=false'
            }
        }

        stage('terraform apply') {
            steps {
                input 'Deploy Infrastructure?'
                sh 'terraform apply tfplan'
            }
        }

        stage('terraform destroy') {
            steps {
                input 'Destroy Infrastructure'
                sh 'terraform destroy --auto-approve'
            }
        }
    }
}