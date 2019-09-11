node('docker') {

    stage 'Checkout'
        checkout scm

    stage 'Clear Environment'
        sh "terraform init"
        sh "yes yes | terraform destroy -var-file=states/harbor-master-jenkins.tfvars"

    stage 'Integration Test'
        sh "bash resources/quick-harbor-linux-slim.sh"
}
