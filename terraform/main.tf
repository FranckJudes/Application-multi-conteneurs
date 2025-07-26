terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "todo_app" {
  image  = "ubuntu-22-04-x64"
  name   = "todo-app-server"
  region = var.region
  size   = "s-1vcpu-1gb"
  ssh_keys = [var.ssh_key_fingerprint]

  tags = ["todo-app", "production"]
}

resource "digitalocean_firewall" "todo_app_firewall" {
  name = "todo-app-firewall"

  droplet_ids = [digitalocean_droplet.todo_app.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

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

output "server_ip" {
  value = digitalocean_droplet.todo_app.ipv4_address
}
