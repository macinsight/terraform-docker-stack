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
  labels {
    label = "traefik.http.routers.myrouter.rule"
    value = "Host(`macinsight.io`)"
  }

  labels {
    label = "traefik.http.routers.api.rule"
    value = "Host(\\`traefik.macinsight.io\\`) && (PathPrefix(\\`/api\\`) || PathPrefix(\\`/dashboard\\`))"
  }
  labels {
    label = "traefik.http.routers.api.service"
    value = "api@internal"
  }
  labels {
    label = "traefik.http.routers.myrouter.entrypoints"
    value = "web"
  }

  labels {
    label = "traefik.http.services.myservice.loadbalancer.server.port"
    value = "80"
  }

  networks_advanced {
    name = docker_network.traefik_network.name
  }
}
