variable "types" {
  type = set(string)
  validation {
    condition     = alltrue([for t in var.types : contains(["ssh", "http", "https", "postgres"], t)])
    error_message = "Each type must be one of: ssh, http, https, or postgres."
  }
}

variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  description = "Description of the security group"
  default     = ""
}

variable "ethertype" {
  type        = string
  description = "Ethernet type"
  default     = "IPv4"
}

variable "direction" {
  type        = string
  description = "Direction of the security group"
}
