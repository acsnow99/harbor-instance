terraform init
yes yes | terraform apply -var-file=states/harbor-master-jenkins.tfvars

ip=$(terraform output | tr -d "instance-ip = -")

# get the cert from the instance
scp -i /Users/alexsnow/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v alexsnow@$ip:~/ca.crt .
# Refresh the list of certificates to trust
sudo update-ca-certificates
# Restart the Docker daemon
sudo service docker restart

sleep 60

# login to docker and push a test image
sudo docker login --username admin --password Harbor12345 $ip
sudo docker tag hello-world:latest $ip/library/hello-world:latest
sudo docker push $ip/library/hello-world:latest