variable "name" {
  description = "Name of the network"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to create the load balancer on"
  type        = string
}

variable "floating_ip" {
  description = "Whether to create a floating IP for the load balancer"
  type        = bool
}

variable "protocols" {
  description = "List of protocols to use for the load balancer"
  type        = map(string)
  default = {
    HTTP  = 80
    HTTPS = 443
  }
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the load balancer"
  type        = list(string)
  default     = []
}

variable "monitor_path" {
  description = "Path to use for health monitor HTTP checks"
  type        = string
  default     = "/"
}

variable "config" {
  type = list(object({
    protocol     = string
    port         = number
    monitor_path = string
    addresses    = list(string)
    name         = string
  }))
  description = "Configuration for each listener and pool"
  validation {
    condition = alltrue([
      for c in var.config : lower(c.protocol) == "http" || lower(c.protocol) == "https"
    ])
    error_message = "Each config.protocol must be either 'HTTP' or 'HTTPS'."
  }
}
