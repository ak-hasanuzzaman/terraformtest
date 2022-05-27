# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "=2.58.0"
#     }
#   }
# }

provider "azurerm" {
   skip_provider_registration = true
   features {
  }
}

resource "azurerm_resource_group" "tftest" {
    name="tfmainrg"
    location="West Europe"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = "West Europe"
  resource_group_name       ="tfmainrg"

  ip_address_type     = "public"
  dns_name_label      = "binarythistlewa"
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
