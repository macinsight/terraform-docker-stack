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
  }
}

