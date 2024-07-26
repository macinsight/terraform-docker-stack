data "external" "env_vars" {
  program = ["bash", "-c", "set -o allexport; source .env; env"]

  # Use the `env` attribute to specify the variables you want to read
  # This will be a map of the environment variables
  result = {
    POSTGRES_USER    = "POSTGRES_USER"
    POSTGRES_PASSWORD = "POSTGRES_PASSWORD"
    POSTGRES_DB      = "POSTGRES_DB"
    REDIS_PASSWORD   = "REDIS_PASSWORD"
  }
}

locals {
  postgres_user     = data.external.env_vars.result["POSTGRES_USER"]
  postgres_password = data.external.env_vars.result["POSTGRES_PASSWORD"]
  postgres_db       = data.external.env_vars.result["POSTGRES_DB"]
  redis_password    = data.external.env_vars.result["REDIS_PASSWORD"]
}

