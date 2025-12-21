# resource "aws_eip" "lb" {
#   domain = "vpc"
# }

# variable "sg_ports" {
#   type        = list(number)
#   description = "list of ingress ports"
#   default     = [8200, 8201, 8300, 9200, 9500]
# }
# resource "aws_security_group" "example" {
#   name        = "test-sg"
#   description = "Allow TLS inbound traffic and all outbound traffic"

#   dynamic "ingress" {
#     for_each = var.sg_ports
#     iterator = port
#     content {
#       from_port   = port.value
#       to_port     = port.value
#       protocol    = "tcp"
#       cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
#     }
#   }

#   dynamic "egress" {
#     for_each = var.sg_ports
#     iterator = port
#     content {
#       from_port   = port.value
#       to_port     = port.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
# }