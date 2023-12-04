output "public_ips" {
  value = digitalocean_droplet.droplet_to_task[*].ipv4_address
}
