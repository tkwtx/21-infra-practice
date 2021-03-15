variable "conf" {}

variable "ip" {}

variable "vpc" {}

variable "subnet" {}

variable "key" {}

variable "security_group_ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 22]
}
