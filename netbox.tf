resource "docker_image" "netbox" {
  name = "netboxcommunity/netbox"
}

resource "docker_container" "netbox" {
  image = docker_image.netbox.image_id
  name  = "netbox"
  
  ports {
    internal = 80
  }

  labels {
    label = "traefik.enable"
    value = true
  }
  labels {
    label = "traefik.http.routers.netbox.rule"
    value = "Host(\"netbox.macinsight.io\")"
  }
  labels {
    label = "traefik.http.routers.netbox.entrypoints"
    value = "http" 
  }
  labels {
    label = "traefik.http.services.netbox.loadbalancer.server.port"
    value = "80"
  }

  networks_advanced {
    name = docker_network.traefik_network.name
  }
}

resource "docker_network" "netbox" {
}
