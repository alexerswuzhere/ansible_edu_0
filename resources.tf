
resource "digitalocean_ssh_key" "my_tf_key" {
   name = var.digital_ocean_key_name
   public_key = tls_private_key.my_key.public_key_openssh
}



resource "digitalocean_droplet" "droplet_to_task" {
  depends_on = [local_sensitive_file.pem_file]
  count = 2
  name = "ansible-1-${count.index}"
  region = var.region
  image = "ubuntu-23-10-x64"
  size = var.droplet_size
  tags = [var.tag1,var.tag2]
  ssh_keys = [digitalocean_ssh_key.my_tf_key.id]
}



resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}



resource "local_sensitive_file" "pem_file" {
  filename = pathexpand("${path.module}/private.pem")
  file_permission = "600"
  directory_permission = "700"
  content = tls_private_key.my_key.private_key_pem
}



resource "local_file" "ssh_public_file" {
  depends_on = [tls_private_key.my_key]
  filename = pathexpand("${path.module}/public.ssh")
  file_permission = "600"
  directory_permission = "700"
  content = tls_private_key.my_key.public_key_openssh
}



resource "local_file" "foo" {
  content  = templatefile("final_file.tftpl",{ip = digitalocean_droplet.droplet_to_task[*].ipv4_address, private_key = local_sensitive_file.pem_file.filename})
  filename = "${path.module}/hosts.txt"
}
