## Application Gateway Deployment *** Don't touch Below Area ***
resource "azurerm_application_gateway" "network" {
  name                = "${var.Configuration["ApplicationGatewayName"]}"
  resource_group_name = "${var.Configuration["ResourcesGroup"]}"
  location            = "${var.Configuration["zone"]}"

  enable_http2 = "${var.Configuration["enable_http2_value"]}"

  sku {
    name     = "${var.Configuration["sku_name"]}"
    tier     = "${var.Configuration["sku_tier"]}"
    capacity = "${var.Configuration["sku_capacity"]}"
  }

  waf_configuration {
    enabled          = false
    firewall_mode    = "Detection"
    rule_set_version = "3.0"
    rule_set_type    = "OWASP"
  }

  gateway_ip_configuration {
    name      = "${var.Configuration["ApplicationGatewayName"]}-GatewayIpConfiguration"
    subnet_id = "${data.azurerm_subnet.SubNet_Obj.id}"
  }

  ssl_certificate {
    name     = "${var.Configuration["CertificateName"]}"
    data     = "${base64encode(file("ssl/certificate.pfx"))}"
    password = "${var.Configuration["CertificatePassword"]}"
  }

  authentication_certificate {
    name = "${var.Configuration["CertificateName"]}"
    data = "${base64encode(file("ssl/certificate.cer"))}"
  }

  frontend_port {
    name = "${var.Configuration["frontend_Https_port_name"]}"
    port = 443
  }

  frontend_port {
    name = "${var.Configuration["frontend_Http_port_name"]}"
    port = 80
  }

  frontend_ip_configuration {
    name                          = "${var.Configuration["frontend_ip_configuration_name"]}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${data.azurerm_subnet.SubNet_Obj.id}"
  }

  backend_address_pool {
    name = "${var.Configuration["backend_address_pool_name"]}"
  }

  backend_http_settings {
    name                  = "${var.Configuration["backend_https_settings_name"]}"
    cookie_based_affinity = "Enabled"
    path                  = "/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 120

    authentication_certificate {
      name = "${var.Configuration["CertificateName"]}"
    }
  }

  backend_http_settings {
    name                  = "${var.Configuration["backend_http_settings_name"]}"
    cookie_based_affinity = "Enabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 120
  }

  http_listener {
    name                           = "${var.Configuration["https_listener_name"]}"
    frontend_ip_configuration_name = "${var.Configuration["frontend_ip_configuration_name"]}"
    frontend_port_name             = "${var.Configuration["frontend_Https_port_name"]}"
    protocol                       = "Https"
    ssl_certificate_name           = "${var.Configuration["CertificateName"]}"
  }

  http_listener {
    name                           = "${var.Configuration["http_listener_name"]}"
    frontend_ip_configuration_name = "${var.Configuration["frontend_ip_configuration_name"]}"
    frontend_port_name             = "${var.Configuration["frontend_Http_port_name"]}"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "${var.Configuration["https_listener_name"]}"
    backend_address_pool_name  = "${var.Configuration["backend_address_pool_name"]}"
    backend_http_settings_name = "${var.Configuration["backend_https_settings_name"]}"
  }

  request_routing_rule {
    name                       = "rule2"
    rule_type                  = "Basic"
    http_listener_name         = "${var.Configuration["http_listener_name"]}"
    backend_address_pool_name  = "${var.Configuration["backend_address_pool_name"]}"
    backend_http_settings_name = "${var.Configuration["backend_http_settings_name"]}"
  }
}
