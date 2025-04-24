# key-pair for ec2
resource "aws_key_pair" "my-key" {
  key_name   = "deployer-key"
  public_key = file("terra-key-ec2.pub")
}

#EC2 code
resource "aws_instance" "server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.my-key.key_name
  vpc_security_group_ids = [aws_security_group.JenkinsSg.id]
  subnet_id              = aws_subnet.subnet_1.id
  user_data = file ("install-jenkins.sh")

    tags = {
      Name = "jenkins"
    }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
}

