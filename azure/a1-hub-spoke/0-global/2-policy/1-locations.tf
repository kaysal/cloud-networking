
# policy definition

resource "azurerm_policy_definition" "policy_def_location" {
  name         = "${var.global.prefix}policy-def-location"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "${var.global.prefix}policy-def-location"

  policy_rule = <<POLICY_RULE
    {
    "if": {
      "not": {
        "field": "location",
        "in": "[parameters('allowedLocations')]"
      }
    },
    "then": {
      "effect": "audit"
    }
  }
POLICY_RULE

  parameters = <<PARAMETERS
    {
    "allowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed locations for resources.",
        "displayName": "Allowed locations",
        "strongType": "location"
      }
    }
  }
PARAMETERS
}

# hub

resource "azurerm_policy_assignment" "hub_policy_assign_location" {
  name                 = "${var.global.prefix}hub-policy-assign-location"
  scope                = local.rg.hub.id
  policy_definition_id = azurerm_policy_definition.policy_def_location.id
  description          = "Policy Assignment created via an Acceptance Test"
  display_name         = "${var.global.prefix}policy-assign-location"

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "${var.global.location}" ]
  }
}
PARAMETERS
}

# spoke1

resource "azurerm_policy_assignment" "spoke1_policy_assign_location" {
  name                 = "${var.global.prefix}spoke2-policy-assign-location"
  scope                = local.rg.spoke1.id
  policy_definition_id = azurerm_policy_definition.policy_def_location.id
  description          = "Policy Assignment created via an Acceptance Test"
  display_name         = "${var.global.prefix}policy-assign-location"

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "${var.global.location}" ]
  }
}
PARAMETERS
}

# spoke2

resource "azurerm_policy_assignment" "spoke2_policy_assign_location" {
  name                 = "${var.global.prefix}spoke2-policy-assign-location"
  scope                = local.rg.spoke2.id
  policy_definition_id = azurerm_policy_definition.policy_def_location.id
  description          = "Policy Assignment created via an Acceptance Test"
  display_name         = "${var.global.prefix}policy-assign-location"

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "${var.global.location}" ]
  }
}
PARAMETERS
}
