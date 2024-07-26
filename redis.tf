resource "docker_image" "redis" {
  name = "redis:latest"
}

resource "docker_container" "redis" {
  image = docker_image.redis.image_id
  name  = "redis_container"
  restart = "always"

  volumes {
    volume_name    = docker_volume.redis.name
    container_path = "/usr/local/etc/redis/"
  }


  networks_advanced {
    name = docker_network.netbox.name
  }
}

resource "docker_volume" "redis" {
  name = "netbox_redis_volume"
}
