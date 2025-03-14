terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "aws_key_pair" "my_key" {
  key_name = "my_key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.example.private_key_pem
  filename = "${path.module}/my_key.pem"
}