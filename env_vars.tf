provider "template" {}

data "local_file" "env_file" {
  filename = "${path.module}/.env"
}

data "template_file" "env_vars" {
  template = data.local_file.env_file.content
  vars = {
    POSTGRES_USER    = regex("(?m)^POSTGRES_USER=(.*)$", data.local_file.env_file.content)[0]
    POSTGRES_PASSWORD = regex("(?m)^POSTGRES_PASSWORD=(.*)$", data.local_file.env_file.content)[0]
    POSTGRES_DB      = regex("(?m)^POSTGRES_DB=(.*)$", data.local_file.env_file.content)[0]
  }
}

locals {
  postgres_user     = data.template_file.env_vars.vars["POSTGRES_USER"]
  postgres_password = data.template_file.env_vars.vars["POSTGRES_PASSWORD"]
  postgres_db       = data.template_file.env_vars.vars["POSTGRES_DB"]
}

