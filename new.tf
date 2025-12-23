# #hello there hi
# module "ec2_instance" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "single-instance"

#   instance_type = "t3a.small"
#   key_name      = "test"
#   monitoring    = false
#   subnet_id     = "subnet-0ed5d2b88c1e41ad5"
#   user_data = <<-EOF
#               #!/bin/bash
#               set -eux

#               # Update system
#               sudo dnf update -y

#               # Install Docker
#               sudo dnf install docker -y
#               sudo systemctl start docker
#               sudo systemctl enable docker

#               # Add ec2-user to docker group
#               sudo usermod -aG docker ec2-user

#               # Install kubectl
#               curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
#               chmod +x kubectl
#               sudo mv kubectl /usr/local/bin/kubectl

#               # Verify kubectl
#               kubectl version --client

#               # Install Minikube
#               curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
#               chmod +x minikube-linux-amd64
#               sudo mv minikube-linux-amd64 /usr/local/bin/minikube

#               # Verify Minikube
#               minikube version

#               # Start Minikube using Docker driver
#               sudo -u ec2-user minikube start --driver=docker

#               # Check Minikube status
#               sudo -u ec2-user minikube status
#               E

#   tags = {
#     Terraform   = "true"
#     Environment = "test"
#   }
# }