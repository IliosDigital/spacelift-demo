variable "instance_count" {
  type = number
}

variable "ingress_ports" {
  type = list(number)
}

variable "egress_ports" {
  type = list(number)
}

variable "allowed_cidr" {
  type = list(string)
}
