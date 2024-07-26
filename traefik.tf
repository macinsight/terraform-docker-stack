resource "docker_network" "traefik_network" {
  name = "traefik"
}

resource "docker_container" "traefik" {
  name  = "traefik"
  image = "traefik:latest"
  restart = "always"

  ports {
    internal = 80
    external = 80
  }

  ports {
    internal = 8080
    external = 8080
  }

  labels {
    label = "traefik.enable"
    value = true
  }

  networks_advanced {
    name = docker_network.traefik_network.name
  }
}
