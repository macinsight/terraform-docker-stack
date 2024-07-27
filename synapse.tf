resource "docker_image" "synapse" {
  name = "matrixdotorg/synapse"
}

resource "docker_container" "synapse" {
  image = docker_image.synapse.image_id
  name  = "synapse"
  
  ports {
    internal = 8008
  }

  labels {
    label = "traefik.enable"
    value = true
  }
  labels {
    label = "traefik.http.routers.synapse.rule"
    value = "Host(\"synapse.macinsight.io\")"
  }
  labels {
    label = "traefik.http.routers.synapse.entrypoints"
    value = "http" 
  }
  labels {
    label = "traefik.http.services.synapse.loadbalancer.server.port"
    value = "8008"
  }

  networks_advanced {
    name = docker_network.traefik.name
  }

  volumes {
    volume_name = docker_volume.synapse_data.name
    container_path = "/config"
  }
}

resource "docker_volume" "synapse_data" {
  name = "synapse_data"
}
