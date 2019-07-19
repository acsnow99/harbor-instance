variable "node_count" {
    description = "If a slave, how many slaves"
}

variable "configfile" {
    description = "File Harbor looks at when installing. Titled 'harbor.yml' when Harbor is downloaded"
}

variable "prefix" {
    description = "Name for the entire system(e.g. harbor-ubuntu)"
}

variable "image" {
    description = "Which operating system to pull from GCP"
}

variable "commandfile" {
    description = "File with instructions on how to install Harbor and other tools, plus any additional instructions after install"
}

variable "machine" {
    description = "Type of GCP machine to create the node on"
    default = "n1-standard-4"
}