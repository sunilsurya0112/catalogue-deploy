pipeline {

    agent {
      node {
         label 'AGENT-1'
           }
         }
    // environment { 
    //      packageVersion = ''
    //      nexusURL = '172.31.83.5:8081'
    // }
    options {
        timeout(time: 1, unit: 'HOURS') 
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'version', defaultValue: '', description: 'What is the artifact version')
        string(name: 'environment', defaultValue: '', description: 'What is the environment?')
    }
//Build
    stages {
        stage('print the version') {
            steps {
                sh """
                    echo "version: ${params.version}"
                    echo "environment: ${params.environment}"
                """
               
            }
        }
        stage('Init') {
            steps {
                sh """
                    cd terraform
                    terraform init --backend-config=${params.environment}/backend.tf -reconfigure
                """
            }
        }
        stage('Plan') {
            
            steps {
                sh """
                    cd terraform
                    terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}"
                """
            }
        }
        stage('Apply') {
            steps {
                sh """
                    cd terraform
                    terraform destroy -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                """
            }
        }


        
    }
//post build
    post { 
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        failure{
            echo "this runs when pipeline is failed, generally used to send some alerts"
        }
        success{
             echo 'I will say hello when pipe line is success'
        }
    }
}