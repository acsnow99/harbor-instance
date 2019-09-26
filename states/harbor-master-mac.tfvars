prefix = "harbor-ubuntu"
commandfile = "resources/dockerce-harbor-master-install-V2.sh"
configfile = "resources/harbor-master.yml"
credentials-file = "/Users/alexsnow/terraform/terraform_keys/terraform-gcp-harbor-2-3ca67fec4859.json"
ssh_user = "alexsnow"
project = "terraform-gcp-harbor-2"

machine = "n1-standard-2"

network = "terraform-gcp-harbor"
subnet = "harbor-1"