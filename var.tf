# Collect Subnet Inforamtion with Resources Group
data "azurerm_subnet" "SubNet_Obj" {
  name                 = "XXXXX"  # Under Virtual network Sub-net name
  virtual_network_name = "XXXXX"  # Virtual network name
  resource_group_name  = "XXXXX"  # Virtual network Resources Group 
}

variable "Configuration" {
  type = "map"
  default = {
    "Env_Tag" = "XX" # Example PP for production
    "ApplicationGatewayName" = "XXXX" # Name what you want for Application Gateway
    "ResourcesGroup"  = "XXXX" # Resources Group which you want to use for.
    "zone" = "East Asia"

    # Application Tier Information
    "sku_name" = "WAF_Medium"
    "sku_tier" = "WAF"
    "sku_capacity" = "2"
    "https_listener_name" = "HTTP-443"
    "http_listener_name" = "HTTP-80"
    "enable_http2_value" = "true"

    # Certification files need to be places under SSL Folder
    "CertificateName" = "XXXX"  # Name for Certificate
    "CertificatePassword" = "***"    # PFX File Password

    # Listeners and Backend Pool Configuration
    "frontend_Https_port_name" = "FrontendPort_HTTPS"
    "frontend_Http_port_name" = "FrontendPort_HTTP"
    "frontend_ip_configuration_name" = "Frontend-PrivateIP"

    "backend_address_pool_name" = "BackendPool-01"
    "backend_https_settings_name" = "Https-Settings"
    "backend_http_settings_name" = "Http-Settings"

  }
}

