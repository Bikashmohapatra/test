#hello there hi
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3a.small"
  key_name      = "test"
  monitoring    = false
  subnet_id     = "subnet-0ed5d2b88c1e41ad5"
  root_block_device = [
    {
      volume_size = 30
    }
  ]
  ############################
  # Enable SSM Login
  #############################
  create_iam_instance_profile = true

  iam_role_name = "ec2-ssm-role"

  iam_role_policies = {
    SSM = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  ############################
  # User Data
  ############################
  user_data = <<-EOF
              #!/bin/bash
              set -eux
              # Detect OS
              if [ -f /etc/os-release ]; then
                . /etc/os-release
              fi

              echo "OS Detected: $NAME"

              # Install SSM Agent if not present
              if ! systemctl status amazon-ssm-agent >/dev/null 2>&1; then
                echo "Installing SSM Agent..."
                dnf install -y amazon-ssm-agent || yum install -y amazon-ssm-agent
              else
                echo "SSM Agent already installed"
              fi

              # Enable and start SSM Agent
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent

              # Verify status
              systemctl status amazon-ssm-agent --no-pager

              # Update system
              sudo dnf update -y

              # Install Jenkins
              sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
              sudo dnf install jenkins -y
              sudo systemctl start jenkins
              sudo systemctl enable jenkins

              # Install Docker
              sudo dnf install docker -y
              sudo systemctl start docker
              sudo systemctl enable docker

              # Add ec2-user to docker group
              sudo usermod -aG docker ec2-user

              # Install kubectl
              curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
              chmod +x kubectl
              sudo mv kubectl /usr/local/bin/kubectl

              # Verify kubectl
              #kubectl version --client

              # Install Minikube
              #curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
              #chmod +x minikube-linux-amd64
              #sudo mv minikube-linux-amd64 /usr/local/bin/minikube

              # Verify Minikube
              #minikube version

              # Start Minikube using Docker driver
              #sudo -u ec2-user minikube start --driver=docker

              # Check Minikube status
              #sudo -u ec2-user minikube status
              EOF

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}