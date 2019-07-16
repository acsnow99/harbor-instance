variable "region" {
    type = "string"
    default = "us-west1"
}

variable "prefix" {
    type = "string"
    default = "google-cloud-compute"
}

variable "node_count" {
    default = "0"
}

variable "image" {
    type = "map"
    default = {
        "debian-vm" = "debian-cloud/debian-9"
        "ubuntu-vm" = "ubuntu-1604-xenial-v20190617"
        "harbor-ubuntu-vm" = "ubuntu-1604-xenial-v20190617"
    }
}
variable "machine" {
    description = "Type of GCP machine to make the nodes on"
    default = "n1-standard-4"
}

variable "commandfile" {
    type = "string"
}
variable "configfile" {
    type = "string"
    description = "File Harbor looks at when installing. Titled 'harbor.yml' when Harbor is downloaded"
}