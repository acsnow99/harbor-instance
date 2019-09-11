sudo apt-get update -y
sudo apt-get install -y chrony dnsmasq dnsutils jq
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
# install docker compose
sudo curl -L --fail https://github.com/docker/compose/releases/download/1.24.0/run.sh -o /usr/local/bin/docker-compose
# executable permissions for compose
sudo chmod +x /usr/local/bin/docker-compose

openssl req -newkey rsa:4096 -nodes -sha256 -keyout ca.key -x509 -days 3650 -out ca.crt -subj "/C=US/ST=Oregon/L=Portland/0=IGNW/OU=Devops/CN=core.harbor.domain"
openssl req -newkey rsa:4096 -nodes -sha256 -keyout harbor.gcp.key -out harbor.gcp.csr -subj "/C=US/ST=Oregon/L=Portland/0=IGNW/OU=Devops/CN=core.harbor.domain"
touch extfile.cnf
echo subjectAltName = IP:${host-ip} > extfile.cnf
openssl x509 -req -days 3650 -in harbor.gcp.csr -CA ca.crt -CAkey ca.key -CAcreateserial -extfile extfile.cnf -out harbor.gcp.crt
sudo mkdir etc/ssl/certs
sudo cp *.crt *.key /etc/ssl/certs

wget https://storage.googleapis.com/harbor-releases/release-1.8.0/harbor-online-installer-v1.8.1.tgz
tar xvzf harbor-online-installer-v1.8.1.tgz
cp /tmp/harbor-config.yml ~/harbor/harbor.yml
sudo ~/harbor/install.sh --with-notary --with-clair 