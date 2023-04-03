# user groupname to lookup all required info.data
data "akamai_contract" "contract" {
  group_name = var.group_name
}

locals {
  # using DSA as our default product in case wrong product type has been provided as input var.
  # our failsave method just because we can. ;-)
  default_product = "prd_Site_Accel"
}

resource "akamai_property_include" "new_specific_rule_tree" {
    contract_id = data.akamai_contract.contract.id
    group_id    = data.akamai_contract.contract.group_id
    product_id  = lookup(var.aka_products, lower(var.product_name), local.default_product)
    name        = var.property_include_name
    rule_format = var.rule_format
    rules       = data.akamai_property_rules_builder.incl2prop_rule_default.json
    type = "COMMON_SETTINGS"
}

# let's activate on staging
resource "akamai_property_include_activation" "my_example" {
  include_id    = resource.akamai_property_include.new_specific_rule_tree.id
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  network       = "STAGING"
  notify_emails = [
    "notify@example.com"
  ]
}