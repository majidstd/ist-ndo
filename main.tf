module "schema_site01_bd" {
  source   = "./modules/bd"
  tenant   = "terraform_ndo"
  schema   = "site01"
  template = "site01"
  vrf_name = "default"
  bd_list = [
    {
      # Provide a Name for the Bridge Domain
      bridge_domain = "bridge_domain01"
      # Intersite BUM is either true or false.
      intersite_bum_traffic = true
      # Layer2 Stretch is either true or false.
      layer2_stretch = true
      # Unknown Unicast is either flood or proxy.
      layer2_unknown_unicast = "flood"
      # Layer3 Multicast is either true or false.
      layer3_multicast = false
      # Optimize WAN Bandwidth is either true or false.
      # If layer2_unknown_unicast is flood set this to false.
      # If layer2_unknown_unicast is proxy set this to true.
      optimize_wan_bandwidth = false
    },
    {
      bridge_domain          = "bridge_domain03"
      intersite_bum_traffic  = true
      layer2_stretch         = true
      layer2_unknown_unicast = "proxy"
      layer3_multicast       = false
      optimize_wan_bandwidth = true
    }
  ]
}

module "schema_site01_app" {
  source   = "./modules/app"
  tenant   = "terraform_ndo"
  schema   = "Site01"
  template = "site01"
  app_list = [
    {
      app_profile = "app_profile02"
    },
    {
      app_profile = "app_profile03"
    }
  ]
}

module "schema_site01_epg" {
  depends_on = [
    module.schema_site01_bd,
    module.schema_site01_app
  ]
  source   = "./modules/epg"
  tenant   = "site01"
  schema   = "site01"
  template = "site01"
  vrf_name = "default"
  epg_list = [
    # Make sure the BD Exists in MSO or that you created it in the previous module.
    {
      bridge_domain     = "bridge_domain01"
      app_profile       = "app_profile01"
      epg               = "epg01"
      contract_consumer = "default"
      contract_provider = "default"
    },
    {
      bridge_domain     = "bridge_domain02"
      app_profile       = "app_profile01"
      epg               = "epg02"
      contract_consumer = "default"
      contract_provider = "default"
    },
    {
      bridge_domain     = "bridge_domain02"
      app_profile       = "app_profile02"
      epg               = "epg03"
      contract_consumer = "default"
      contract_provider = "default"
    }
  ]
}
