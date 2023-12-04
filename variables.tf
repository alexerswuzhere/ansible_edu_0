variable "digitalocean_token" {
  type = string
}

variable "region" {
  type = string
  default = "AMS3"
}

variable "droplet_size" {
    type = string
    default = "s-1vcpu-1gb"
}


variable "digital_ocean_key_name" {
  description = "input your public ssh key name in digital_ocean"
}

variable "tag1" {
  description = "input your first tag to digital_ocean droplet"
  type = string
}

variable "tag2" {
  description = "input your second tag to digital_ocean droplet"
  type = string
}