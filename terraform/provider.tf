terraform {
  required_providers {
    ncloud = {
      source = "NaverCloudPlatform/ncloud"
      version = "2.3.16"
    }
  }
}

provider "ncloud" {
  support_vpc = "true"
}

