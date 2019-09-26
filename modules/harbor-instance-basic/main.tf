# the Harbor host is itself; config file has host field set to its ip address
data "template_file" "install-config-ip" {
    
    template = "${file("${var.configfile}")}"
    
    vars = {
        host-ip = "${var.hostname}"
    }
}

data "template_file" "install-command-ip" {
    
    template = "${file("${var.commandfile}")}"
    
    vars = {
        host-ip = "${google_compute_instance.harbor.network_interface.0.access_config.0.nat_ip}"
    }
}

# Create Harbor node
resource "google_compute_instance" "harbor" {
    name = "${var.prefix}"
    machine_type = "${var.machine}"
    
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
    
    connection {
            type = "ssh"
            host = "${google_compute_instance.harbor.network_interface.0.access_config.0.nat_ip}"
            user = "alexsnow"
            private_key = "${file("${var.ssh_private_key}")}"
    }
    provisioner "file" {
        content = "${data.template_file.install-config-ip.rendered}"
        destination = "/tmp/harbor-config.yml"
    }
    provisioner "file" {
        content = "${data.template_file.install-command-ip.rendered}"
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