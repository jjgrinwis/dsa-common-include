terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 3.5.0" // for HCL rules
    }
  }
  required_version = ">= 0.13"
}