terraform init
yes yes | terraform apply -var-file=states/harbor-master-mac.tfvars

ip=$(terraform output | tr -d "instance-ip = -")

# get the cert from the instance
scp -i /Users/alexsnow/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v alexsnow@$ip:~/ca.crt .
sudo mkdir ~/.docker/certs.d
sudo mkdir ~/.docker/certs.d/core.harbor.domain
sudo mv ca.crt ~/.docker/certs.d/core.harbor.domain/ca.crt

sudo cp /etc/hosts ./hosts-copy
echo "${ip} core.harbor.domain" | sudo tee -a /etc/hosts

killall Docker && open /Applications/Docker.app

sleep 60

# login to harbor through docker and push a test image
sudo docker login --username admin --password Harbor12345 core.harbor.domain
sudo docker tag hello-world:latest core.harbor.domain/library/hello-world:latest
sudo docker push core.harbor.domain/library/hello-world:latest