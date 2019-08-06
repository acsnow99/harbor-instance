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
    type = "string"
    default = "ubuntu-1604-xenial-v20190617"
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

variable "credentials-file" {
    type = "string"
    default = "~/terraform/terraform_keys/terraform-gcp-harbor-80a453b96ca7.json"
}

variable "ssh_user" {
    description = "The username linked with your ssh keys"
}
variable "ssh_public_key" {
    description = "Path to your public ssh key"
    default = "~/.ssh/id_rsa.pub"
}
variable "ssh_private_key" {
    description = "Path to your private ssh key"
    default = "~/.ssh/id_rsa"
}