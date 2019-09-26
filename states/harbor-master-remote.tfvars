prefix = "harbor-ubuntu-managed"
node_count = "1"
commandfile = "resources/dockerce-harbor-master-install-V2.sh"
configfile = "resources/harbor-master.yml"
credentials-file = "~/terraform_harbor/terraform_key.json"
ssh_user = "alexsnow"
project = "terraform-gcp-harbor-2"

network = "terraform-gcp-harbor"
subnet = "harbor-1"

hostname = "core.harbor.domain"