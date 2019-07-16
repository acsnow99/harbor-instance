sudo apt-get update -y
sudo apt-get install -y chrony dnsmasq dnsutils jq
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
#sudo systemctl enable dnsmasq
#echo 'server=/consul/127.0.0.1#8600' | sudo tee /etc/dnsmasq.d/10-consul
#echo 'prepend domain-name-servers 127.0.0.1;' | sudo tee --append /etc/dhcp/dhclient.conf
#echo 'prepend domain-search \"consul\", \"node.consul\";' | sudo tee --append /etc/dhcp/dhclient.conf
#echo 'server 169.254.169.123 prefer iburst' | sudo tee --append /etc/chrony.conf
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
# install docker compose
sudo curl -L --fail https://github.com/docker/compose/releases/download/1.24.0/run.sh -o /usr/local/bin/docker-compose
# executable permissions for compose
sudo chmod +x /usr/local/bin/docker-compose


sudo apt-get install wget
# download install files from harbor
wget https://storage.googleapis.com/harbor-releases/release-1.8.0/harbor-online-installer-v1.8.1.tgz
# attempt to unzip those files
tar xvf harbor-online-installer-v1.8.1.tgz
# use config file to set up domain in .yml file
cp /tmp/harbor-config.yml ~/harbor/harbor.yml

# final install step
sudo ~/harbor/install.sh