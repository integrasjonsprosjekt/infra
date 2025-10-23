variable "name" {
  description = "Name of the VM instances"
  type        = string
  default     = "frontend-vm"
}

variable "flavor" {
  description = "Flavor for the VM instances"
  type        = string
  default     = "gx3.4c2r"
}

variable "image_id" {
  type    = string
  default = "cf5dc427-0a2d-41ea-a9e8-d3e62e8477d0"
}

// ID of the subnet to place the VMs in
variable "subnet_id" {
  description = "ID of the subnet to assign fixed IPs from"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group names to assign to the VMs"
  type        = list(string)
}

variable "user_data" {
  description = "Path to a user data file"
  type        = string
}

variable "volume_ids" {
  type = list(string)
}

variable "floating_ip" {
  description = "Whether to assign a floating IP to the VM"
  type        = bool
  default     = false
}
