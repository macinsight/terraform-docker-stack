resource "docker_image" "netbox" {
  name = "netboxcommunity/netbox:latest"
}

resource "docker_container" "netbox" {
  image = docker_image.netbox.image_id
  name  = "netbox"
  
  ports {
    internal = 80
  }

  labels = {
    "traefik.enable"                      = "true"
    "traefik.http.routers.netbox.rule"    = "Host(\"${docker_container.netbox.name}.macinsight.io\")"
    "traefik.http.services.netbox.loadbalancer.server.port" = "80"
  }

  networks_advanced {
    name = docker_network.traefik_network.name
  }
}
