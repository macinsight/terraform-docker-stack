provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "cloudflare" {
  # Token pulled via ENV
}

provider "postgresql" {
  host = docker_container.postgres.name

}
