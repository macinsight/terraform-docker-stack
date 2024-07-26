resource "docker_image" "postgres" {
  name = "postgres:latest"
}

resource "docker_container" "postgres" {
  image = docker_image.postgres.latest
  name  = "postgres_container"
  restart = "always"

  ports {
    internal = 5432
    external = 5432
  }

  env = [
    "POSTGRES_USER=${local.postgres_user}",
    "POSTGRES_PASSWORD=${local.postgres_password}",
    "POSTGRES_DB=${local.postgres_db}"
  ]

  volumes {
    host_path      = "/path/to/local/postgres/data"
    container_path = "/var/lib/postgresql/data"
  }


  networks_advanced {
    name = docker_network.netbox.name
  }
}

resource "docker_volume" "postgres" {
}
