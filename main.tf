provider "google" {
    credentials = "${file(var.credentials-file)}"
    project = "terraform-gcp-harbor"
    region = "${var.region}"
    zone = "${var.region}-a"
}

resource "google_compute_firewall" "default" {
    name = "${var.prefix}-firewall"
    network = "terraform-gcp-harbor"
    
    allow {
        protocol = "tcp"
    }
}

module "harbor-instance" {
    source = "./modules/harbor-instance-basic"

    node_count = "${var.node_count}"
    configfile = "${var.configfile}"
    prefix = "${var.prefix}-harbor"
    image = "${var.image}"
    commandfile = "${var.commandfile}"
    machine = "${var.machine}"
    ssh_user = "${var.ssh_user}"
    ssh_private_key = "${var.ssh_private_key}"
    ssh_public_key = "${var.ssh_public_key}"
}