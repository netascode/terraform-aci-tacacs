resource "aci_rest" "aaaTacacsPlusProvider" {
  dn         = "uni/userext/tacacsext/tacacsplusprovider-${var.hostname_ip}"
  class_name = "aaaTacacsPlusProvider"
  content = {
    name               = var.hostname_ip
    descr              = var.description
    authProtocol       = var.protocol
    monitorServer      = var.monitoring == true ? "enabled" : "disabled"
    monitoringUser     = var.monitoring == true ? var.monitoring_username : null
    monitoringPassword = var.monitoring == true ? var.monitoring_password : null
    key                = var.key
    port               = var.port
    retries            = var.retries
    timeout            = var.timeout
  }

  lifecycle {
    ignore_changes = [content["key"], content["monitoringPassword"]]
  }
}

resource "aci_rest" "aaaRsSecProvToEpg" {
  dn         = "${aci_rest.aaaTacacsPlusProvider.id}/rsSecProvToEpg"
  class_name = "aaaRsSecProvToEpg"
  content = {
    tDn = var.mgmt_epg == "oob" ? "uni/tn-mgmt/mgmtp-default/oob-${var.mgmt_epg_name}" : "uni/tn-mgmt/mgmtp-default/inb-${var.mgmt_epg_name}"
  }
}
