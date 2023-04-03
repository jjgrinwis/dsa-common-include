# show id of our include
output "include_id" {
    description = "show the id of our newly created include"
    value = resource.akamai_property_include.new_specific_rule_tree.id
}