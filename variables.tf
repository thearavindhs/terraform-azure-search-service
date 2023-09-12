variable "environment" {
  description = "Environment for resource naming"
  type        = string
  nullable    = false
}

variable "location" {
  description = "Default location for resources"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Default tags to be added to resources"
  type        = map(string)
  default = {
    terraform = "true"
  }
}

variable "cognitive_search_name" {
  description = "The name of the Azure Cognitive Search"
  type = "string"
  nullable = false
}

variable "sku" {
  description = "The SKU for Azure Cognitive Search"
  default     = "standard" # Change this to your desired SKU
}

variable "replica_count" {
  description = "The number of replicas for Azure Cognitive Search"
  default     = 1 # Change this to your desired replica count
}

variable "partition_count" {
  description = "The number of partitions for Azure Cognitive Search"
  default     = 1 # Change this to your desired partition count
}

variable "allowed_ips" {
  description = "A list of inbound IPv4 addresses or CIDRs allowed to access the Search Service. Requests from other IP addresses will be blocked by the Search Service's firewall."
  type        = list(string)
  default     = []
}