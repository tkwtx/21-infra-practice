variable "subnet" {}

variable "vpc" {}

variable "security_group_ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 443]
}

variable "target_instance" {
  type = list(string)
  description = "List of instance IDs to be registered in the target group."
}