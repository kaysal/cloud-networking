
output "action_grp" {
  value     = azurerm_monitor_action_group.action_grp
  sensitive = "true"
}
