provider "google" {
    credentials = "${file("~/terraform/terraform_keys/terraform-gcp-harbor-80a453b96ca7.json")}"
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
    image = "${lookup(var.image, var.prefix)}"
    commandfile = "${var.commandfile}"
    machine = "${var.machine}"
}