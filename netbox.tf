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


  networks_advanced {
    name = docker_network.netbox.name
  }

  env = [
  "REDIS_PASSWORD=${local.redis_password}",
  "REDIS_HOST=redis_container",
  "DB_HOST=postgres_container",
  "DB_USER=${local.postgres_user}",
  "DB_PASSWORD=${local.postgres_password}",
  "DB_NAME=netbox"
  ]
  volumes {
    volume_name = docker_volume.netbox_data.name
    container_path = "/config"
  }
}

resource "docker_network" "netbox" {
  name = "netbox_internal"
}

resource "docker_volume" "netbox_data" {
  name = "netbox_data"
}
