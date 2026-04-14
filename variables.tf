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
variable "aws_region" {
  type = string
}
variable "instance_type" {
  description = "EC2 instance type passed from Spacelift"
  type        = string
}
