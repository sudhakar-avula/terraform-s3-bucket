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
                    sh "ls -al" // Print the contents of the current directory for debugging purposes
                    echo "Git clone begin"
                    dir("terraform") {
                        sh "pwd" // Print the current working directory for debugging purposes
                        git branch: 'main', url: 'https://github.com/sudhakar-avula/terraform-s3-bucket.git'
                    }
                    echo "Git clone successful!"
                }
            }
        }

        stage('Plan') {
            steps {
                script {
                    dir("terraform") {
                        sh "pwd" // Print the current working directory for debugging purposes
                        sh 'terraform init'
                         sh "terraform plan -out tfplan"
                    }
                    echo "terraform repo checkout success!"
                }
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
                    def plan = readFile 'terraform/tfplan'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
               echo "Apply begin"
                    dir("terraform") {
                        sh "pwd" // Print the current working directory for debugging purposes
                        sh "terraform apply -input=false tfplan"
                    }
               echo "Apply end"
            }
        }
    }

  }
