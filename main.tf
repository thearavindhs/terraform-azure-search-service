/**
# create the resource group for the azure to be placed in
resource "azurerm_resource_group" "cognitive_search_resource_group" {
  name     = "cognitive-search-resource-group-${local.environment}"
  location = local.default_location
  tags     = local.default_tags
}

# firewall rules for the cognitive search
https://learn.microsoft.com/en-us/azure/search/service-configure-firewall

# create the cognitive search
resource "azurerm_search_service" "cognitive_search" {
  name = "vpc-cognitive-search-${local.environment}" # name must be globally unique
  location = azurerm_resource_group.cognitive_search_resource_group.location
  resource_group_name = azurerm_resource_group.cognitive_search_resource_group.name 
  sku = "free"
  tags = merge(local.default_tags, {
    "name"            = "vpc-cognitive-search-${local.environment}"
    "resource-group"  = azurerm_resource_group.cognitive_search_resource_group.name
  }) 
}

# create the log-analytics workspace for the cognitive search
resource "azurerm_log_analytics_workspace" "cognitive_search_log_analytics_workspace" {
  name                = "vpc-cognitive-search-log-analytics-workspace-${local.environment}"
  location            = azurerm_resource_group.cognitive_search_resource_group.location
  resource_group_name = azurerm_resource_group.cognitive_search_resource_group.name
  tags = merge(local.default_tags, {
    "name"            = "vpc-cognitive-search-log-analytics-workspace-${local.environment}"
    "resource-group"  = azurerm_resource_group.cognitive_search_resource_group.name
  })
}

# create the diagnostic settings for the cognitive search
resource "azurerm_monitor_diagnostic_setting" "cognitive_search_diagnostic_setting" {
  name                = "vpc-cognitive-search-diagnostic-${local.environment}"
  target_resource_id  = azurerm_search_service.cognitive_search.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.cognitive_search_log_analytics_workspace.id
  
  enabled_log {
    category = "OperationLogs"
  }

  metric {
    category = "AllMetrics"
  }
}
*/

# create the unique suffix for to be used for all resources
resource "random_id" "unique_suffix" {
  byte_length = 4
}

# create the resource group for the azure to be placed in
resource "azurerm_resource_group" "cognitive_search_resource_group" {
  name     = "cognitive-search-resource-group-${var.environment}-${random_id.unique_suffix.hex}"
  location = var.location
  tags     = var.tags
}

# create the cognitive search
resource "azurerm_search_service" "cognitive_search" {
  name = var.cognitive_search_name # name must be globally unique
  location = azurerm_resource_group.cognitive_search_resource_group.location
  resource_group_name = azurerm_resource_group.cognitive_search_resource_group.name 
  sku = var.sku
  replica_count = var.replica_count
  partition_count = var.partition_count
  allowed_ips = var.allowed_ips
  tags = merge(var.tags, {
    "name"            = var.cognitive_search_name
    "resource-group"  = azurerm_resource_group.cognitive_search_resource_group.name
  }) 
}

# create the log-analytics workspace for the cognitive search
resource "azurerm_log_analytics_workspace" "cognitive_search_log_analytics_workspace" {
  name                = "vpc-cognitive-search-log-analytics-workspace-${var.environment}-${random_id.unique_suffix.hex}"
  location            = azurerm_resource_group.cognitive_search_resource_group.location
  resource_group_name = azurerm_resource_group.cognitive_search_resource_group.name
  tags = merge(var.tags, {
    "name"            = "vpc-cognitive-search-log-analytics-workspace-${var.environment}-${random_id.unique_suffix.hex}"
    "resource-group"  = azurerm_resource_group.cognitive_search_resource_group.name
  })
}

# create the diagnostic settings for the cognitive search
resource "azurerm_monitor_diagnostic_setting" "cognitive_search_diagnostic_setting" {
  name                = "vpc-cognitive-search-diagnostic-${var.environment}-${random_id.unique_suffix.hex}"
  target_resource_id  = azurerm_search_service.cognitive_search.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.cognitive_search_log_analytics_workspace.id
  
  enabled_log {
    category = "OperationLogs"
  }

  metric {
    category = "AllMetrics"
  }
}





