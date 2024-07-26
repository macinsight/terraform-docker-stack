terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = " ~> 3.0.2"
    }
    template = {
      source = "hashicorp/template"
      version = "~> 2.0"
    }
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.22.0"
    }
  }
}

