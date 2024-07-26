resource "docker_image" "postgres" {
  name = "postgres:latest"
}

resource "docker_container" "postgres" {
  image = docker_image.postgres.image_id
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
    volume_name = docker_volume.postgres.name
    container_path = "/var/lib/postgresql/data"
  }


  networks_advanced {
    name = docker_network.netbox.name
  }
}

resource "docker_volume" "postgres" {
  name = "netbox_postgres_volume"
}

resource "postgresql_database" "" {
  name              = local.postgres_db
}
