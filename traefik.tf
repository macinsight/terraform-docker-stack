resource "docker_network" "traefik_network" {
  name = "traefik"
}

resource "docker_container" "traefik" {
  name  = "traefik"
  image = "traefik:latest"
  restart = "always"
  command = [
    "--api.insecure=true",
    "--api.dashboard=true",
    "--providers.docker=true",
    "--log.level=DEBUG"
  ]

  volumes {
    container_path = "/var/run/docker.sock"
    host_path = "/var/run/docker.sock"
    read_only = true
  }
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

  labels {
    label = "traefik.http.routers.api.rule"
    value = "Host(`traefik.macinsight.io`) && (PathPrefix(`/api`) || PathPrefix(`/dashboard`))"
  }
  labels {
    label = "traefik.http.routers.api.service"
    value = "api@internal"
  }

  labels {
    label = "traefik.entryPoints.web.address"
    value = ":80"
  }
  networks_advanced {
    name = docker_network.traefik_network.name
  }
}
