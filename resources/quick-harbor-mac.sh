terraform init
yes yes | terraform apply -var-file=states/harbor-master-mac.tfvars

ip=$(terraform output | tr -d "instance-ip = -")

# get the cert from the instance
scp -i /Users/alexsnow/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v alexsnow@$ip:~/ca.crt .
sudo mkdir ~/.docker/certs.d
sudo mkdir ~/.docker/certs.d/$ip
sudo mv ca.crt ~/.docker/certs.d/$ip/ca.crt

killall Docker && open /Applications/Docker.app

sleep 60

# login to docker and push a test image
sudo docker login --username admin --password Harbor12345 $ip
sudo docker tag hello-world:latest $ip/library/hello-world:latest
sudo docker push $ip/library/hello-world:latest