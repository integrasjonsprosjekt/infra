variable "name" {
  description = "The name of the network"
  type        = string
}

variable "subnet_cidr" {
  description = "A map of subnet names to CIDR blocks"
  type        = map(string)
  validation {
    condition     = alltrue([for cidr in values(var.subnet_cidr) : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}\\/[0-9]+$", cidr))])
    error_message = "All values must be valid CIDR blocks"
  }
}
