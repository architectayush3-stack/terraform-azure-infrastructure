terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.47.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "axion-rg123456"
    storage_account_name = "axionstg45678"
    container_name       = "backendcontainer"
    key                  = "axion-backend.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "b5f8c6f4-82ed-423f-a5db-bf8976318b55"
}

