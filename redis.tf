resource "docker_image" "redis" {
  name = "redis:latest"
}

resource "docker_container" "redis" {
  image = docker_image.redis.latest
  name  = "redis_container"
  restart = "always"

  env = [
    "REDIS_PASSWORD=${local.redis_password}"
  ]

  volumes {
    volume_name    = docker_volume.redis.name
    container_path = "/data"
  }


  networks_advanced {
    name = docker_network.netbox.name
  }
}

resource "docker_volume" "redis" {
  name = "netbox_redis_volume"
}
