# the Harbor host is itself; config file has host field set to its ip address
data "template_file" "install-config-ip" {
    count = "${var.node_count}"
    template = "${file("${var.configfile}")}"
    
    vars = {
        host-ip = "${google_compute_instance.harbor[count.index].network_interface.0.access_config.0.nat_ip}"
    }
}

data "template_file" "install-command-ip" {
    count = "${var.node_count}"
    template = "${file("${var.commandfile}")}"
    
    vars = {
        host-ip = "${google_compute_instance.harbor[count.index].network_interface.0.access_config.0.nat_ip}"
    }
}

# Create Harbor node
resource "google_compute_instance" "harbor" {
    name = "${var.prefix}-${count.index}"
    machine_type = "${var.machine}"
    count = "${var.node_count}"
    allow_stopping_for_update = "true"
    boot_disk {
         initialize_params {
             image =  "${var.image}"
         }
    }

    network_interface {
        network = "${var.network}"
        subnetwork = "${var.subnet}"
        access_config {
            # nat_ip is here
        }
    }

    metadata = {
        ssh-keys = "${var.ssh_user}:${file("${var.ssh_public_key}")}"
    }
}

# installs Harbor and other necessary tools
resource "null_resource" "install-harbor" {
    count = "${var.node_count}"
    connection {
            type = "ssh"
            host = "${google_compute_instance.harbor[count.index].network_interface.0.access_config.0.nat_ip}"
            user = "alexsnow"
            private_key = "${file("${var.ssh_private_key}")}"
    }
    provisioner "file" {
        content = "${data.template_file.install-config-ip[count.index].rendered}"
        destination = "/tmp/harbor-config.yml"
    }
    provisioner "file" {
        content = "${data.template_file.install-command-ip[count.index].rendered}"
        destination = "/tmp/run-command.sh"
    }
    provisioner "remote-exec" {
        inline = [
            # uses the file from the other provisioner to install docker and download harbor
            "sudo chmod 755 /tmp/run-command.sh",
            "sudo /tmp/run-command.sh",
        ]
    }
}