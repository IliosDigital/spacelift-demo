provider "aws" {
  region = var.aws_region
}
data "aws_ssm_parameter" "latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
resource "aws_security_group" "demo_sg" {
  name        = "spacelift-demo-sg"
  description = "Security group from Spacelift variables"

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr
    }
  }

  dynamic "egress" {
    for_each = var.egress_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "spacelift-demo-sg"
  }
}

resource "aws_instance" "demo_server" {
  count                  = var.instance_count
  ami                    = data.aws_ssm_parameter.latest_ami.value
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  tags = {
    Name = "demo-server-${count.index + 1}"
  }
}
