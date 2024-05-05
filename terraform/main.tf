terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.2.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "2.2.0"
    }
  }
}

provider "vault" {
  # Configuration options
}

provider "nomad" {
  # Configuration options
}
