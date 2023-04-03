variable "group_name" {
  description = "Akamai group to use this resource in"
  type        = string
}

variable "rule_format" {
    description = "Akamai rule format"
    type = string
    default = "v2023-01-05"  
}

variable "product_name" {
    description = "Akamai product name to use"
    type = string
    default = "dsa"
}

variable "property_include_name" {
    description = "Akamai property include name"
    type = string
}

# map of akamai products, just to make life easy
variable "aka_products" {
  description = "map of akamai products"
  type        = map(string)

  default = {
    "ion" = "prd_Fresca"
    "dsa" = "prd_Site_Accel"
    "dd"  = "prd_Download_Delivery"
  }
}