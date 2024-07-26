variable "zone_id" {
  default = "6ff85f88b21749185fd1f2b42777aff4"
}

variable "account_id" {
  default = "32b04ee3ac1abf8207c6c3a1abc25e18"
}

variable "domain" {
  default = "macinsight.io"
}

resource "cloudflare_record" "netbox" {
  zone_id = var.zone_id
  name = "netbox"
}
