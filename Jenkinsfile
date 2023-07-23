pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                script {
                    echo "checkout begin"
                    sh "ls -al" // Print the contents of the current directory for debugging purposes
                    dir("terraform") {
                        sh "pwd" // Print the current working directory for debugging purposes
                        git "https://github.com/sudhakar-avula/terraform-s3-bucket.git"
                    }
                    echo "checkout end"
                }
            }

        stage('Plan') {
            steps {
                echo "Plan begin"
                sh 'pwd;cd terraform/ ; terraform init'
                sh "pwd;cd terraform/ ; terraform plan -out tfplan"
                sh 'pwd;cd terraform/ ; terraform show -no-color tfplan > tfplan.txt'
                echo "Plan begin"
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
               echo "Apply begin"
                sh "pwd;cd terraform/ ; terraform apply -input=false tfplan"
               echo "Apply end"
            }
        }
    }

  }
