provider "docker" {
  host = "unix:///var/run/docker.sock"
}
provider "cloudflare" {
  # Token pulled via ENV
}
