terraform init
yes yes | terraform apply -var-file=states/harbor-master-jenkins.tfvars

ip=$(terraform output | tr -d "instance-ip = -")

# get the cert from the instance
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v alexsnow@$ip:~/ca.crt .
# Refresh the list of certificates to trust
mkdir /etc/docker/certs.d/$ip
mv ca.crt /etc/docker/certs.d/$ip/
# Restart the Docker daemon
service docker restart

sleep 60

# login to docker and push a test image
docker login --username admin --password Harbor12345 $ip
docker tag hello-world:latest $ip/library/hello-world:latest
docker push $ip/library/hello-world:latest