terraform {
  required_providers {
    mso = {
      source = "CiscoDevNet/mso"
      version = "0.6.0"
    }
  }
}

provider "mso" {
  # MSO URL for API Calls
  url = "https://${var.mso_hostname}"
  # Platform is either mso or nd
  # platform = "nd"
  # insecure is for self-signed certificates.  false if you have a public signed certificate installed for the webpage.
  insecure = true
  # MSO Username
  username = var.mso_user
  # MSO Password
  password = var.mso_password
  # MSO Login Domain.  Default is Local
  domain = var.mso_domain
  # PLatform Nexus Dashboard
  platform = "nd"
}
