# Configure end-to-end SSL with Azure Application Gateway by Terraform

Terraform is amazing and little bit daunting task. Its safe also best practice to execute terraform plan before terraform apply. 

## Pre-Requirement

1. Resources Group
2. Virtual network and Sub-net. 
3. SSL Certification CER and PFX format.

## Installation

1. Adjust information as per your environment under var.tf file.

```bash
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
    "CertificateName" = "LFDigital"  # Name for Certificate
    "CertificatePassword" = "DTA"    # PFX File Password

    # Listeners and Backend Pool Configuration
    "frontend_Https_port_name" = "FrontendPort_HTTPS"
    "frontend_Http_port_name" = "FrontendPort_HTTP"
    "frontend_ip_configuration_name" = "Frontend-PrivateIP"

    "backend_address_pool_name" = "BackendPool-01"
    "backend_https_settings_name" = "Https-Settings"
    "backend_http_settings_name" = "Http-Settings"

  }
}

```
2. Please Certificate files under SSL Folder. Rename certificates as per the script 

  a. certificate.pfx

  b. certificate.cer

If you want to use your custom name then please adjust under main.tf file. 

## Usage

```python
az login
terraform init # This step will complete plugin installation
terrafrom plan
terraform apply

Execution time avg 13 - 15 min. 
```

Leave comment if you faced any issue or need any help.
