module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3a.small"
  key_name      = "test"
  monitoring    = false
  subnet_id     = "subnet-0ed5d2b88c1e41ad5"

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}