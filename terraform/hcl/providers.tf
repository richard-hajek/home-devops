terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.3"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.1.101:8006/api2/json"
  pm_debug = true
  pm_tls_insecure = true
}
