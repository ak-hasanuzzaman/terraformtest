# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "=2.58.0"
#     }
provider "azurerm" {
    features {}
}
terraform {
    backend "azurerm" {
        resource_group_name  = "tf_rg_blogstore"
        storage_account_name = "terraformstorage20222"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

# provider "azurerm" {
#   subscription_id = "377e7ff2-5e8e-4a7c-8206-21f2def57cb2"
#   client_id       = "88cd2b23-c23f-48e2-bfa6-48744bb84b64"
#   client_secret   = "sPY8Q~eXL8ONIOfN5vvU.ncPQeFPnGpP8Yjy_azF"
#   tenant_id       = "173e4839-7355-4b97-b77f-22ad08b4741b"
#    skip_provider_registration = true
#    features {
#   }
# }

resource "azurerm_resource_group" "tftest" {
    name="tfmainrg"
    location="West Europe"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = "West Europe"
  resource_group_name       ="tfmainrg"

  ip_address_type     = "public"
  dns_name_label      = "binarythistlewa01"
  os_type             = "Linux"

  image_registry_credential {
    username = "ahasanuzzaman"
    password = "OhP@ss321"
    server   = "hub.docker.com"
  }

  container {
      name            = "weatherapi"
      image           = "ahasanuzzaman/weatherapi:jhooq-docker-demo"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}
