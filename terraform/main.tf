terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a new Droplet
resource "digitalocean_droplet" "todo_app" {
  image  = "ubuntu-22-04-x64"
  name   = "todo-app-server"
  region = var.region
  size   = "s-1vcpu-1gb"
  ssh_keys = [var.ssh_key_fingerprint]

  tags = ["todo-app", "production"]
}

# Create a firewall
resource "digitalocean_firewall" "todo_app_firewall" {
  name = "todo-app-firewall"

  droplet_ids = [digitalocean_droplet.todo_app.id]

  # SSH
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # HTTP
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # HTTPS
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # All outbound traffic
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Output the IP address of the Droplet
output "server_ip" {
  value = digitalocean_droplet.todo_app.ipv4_address
}
