prefix = "harbor-in-docker"
node_count = "1"
commandfile = "resources/dockerce-harbor-master-install.sh"
configfile = "resources/harbor-master.yml"
ssh_user = "alexsnow"
ssh_public_key = "./creds/id_rsa.pub"
ssh_private_key = "./creds/id_rsa"
credentials-file = "./creds/gcp-cred.json"