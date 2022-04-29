resource "proxmox_lxc" "kalliope" {
  target_node  = "proxmox"
  hostname     = "kalliope"
  ostemplate   = "local:vztmpl/archlinux-kalliope.tar.gz"

  ostype       = "archlinux"

  password     = "UNUSED"
  unprivileged = false

  start = true
  cmode = "shell"

  ssh_public_keys = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6qmXPmyS/fG4gIEOuYl8gmeHIP4iEoxTx5jnfH1YmfVUylKO/t+1JvZ/2CUj7ABQc1ts0p19ntamGSzG8dqzhXmWIV5AyWlyNZIyzzgZKHprUd8pmwd/SP14hG3FHwhFU4g1gsE/IEty/ha0Ukb0EDEzookiXU3+WysAfUyZloiDu8mh8+UZs0l9Yhn6Ksg3IGHgQQbzjv2ttMMv2nxElU4WPADrSo5rWsLlg4Jo9F+kCUAq6EDOKT1MHxsM0UBwPq/y2ZAEpuzEbqAEpAkOKjZhvsMNb7jqSilecxO0p/gVv8j5WIq3Oy6G9yvEXbPp2NvxXhSejrizNj2T+kY7jLu7sEM11RApXuvJLrz3xmrsKeYUEX9gOXI3q0xM/EydKUdM/Mp6ZmTHdN/+2KVuMXzkFqma/VXqoYY34o2CGde4MKmXDpUNMGrvTm/ZffhO2oVJkPyUtdZwJlno6MYCULfzDed7He6WjQH3TF2Z4qOxTe9h39F8fioEz4suJvNE= meowxiik@laptop-games
  EOT

  hookscript = "local:snippets/autostarts.pl"

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }

  features {
    nesting = true
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
    ip6    = "dhcp"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    storage = "/media/home"
    volume  = "/media/home"
    mp      = "/home"
    size    = "8G"
  }

}
