resource "docker_network" "traefik_network" {
  name = "traefik"
}

resource "docker_container" "traefik" {
  name  = "traefik"
  image = "traefik:v2.5"
  restart = "always"

  ports {
    internal = 80
    external = 80
  }

  ports {
    internal = 8080
    external = 8080
  }

  volumes {
    volume_name    = "traefik"
    container_path = "/etc/traefik/traefik.yml"
  }

  labels {
    label = "traefik.enable"
    value = true
  }

  networks_advanced {
    name = docker_network.traefik_network.name
  }
}
