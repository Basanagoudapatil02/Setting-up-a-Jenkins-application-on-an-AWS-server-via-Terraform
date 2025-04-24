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

output "instance_public_ip" {
  value = aws_instance.server.public_ip
}




















  # user_data = <<-EOF
  #             #!/bin/bash
  #             chmod 400 your_private_key.pem
  #             chown user:group your_private_key.pem

  #             # Install updates
  #             apt-get -y update

  #             # Install Java (required for Jenkins)
  #             apt install -y openjdk-22-jre-headless

  #             # Add Jenkins repository
  #             sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  #             https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  #             echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  #             https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  #             /etc/apt/sources.list.d/jenkins.list > /dev/null
             
  #             # Install Jenkins
  #             apt-get update
  #             apt-get install -y jenkins
  #              s

  #             # Start Jenkins service
  #             systemctl start jenkins
  #             systemctl enable jenkins

  #             # Install git
  #             apt-get install -y git
  #             EOF







/*
   # User data to install Jenkins during instance launch
  user_data = <<-EOF
              #!/bin/bash
              chmod 400 your_private_key.pem
              chown user:group your_private_key.pem
              EOF

     connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("tf-key-pair")  # Replace with the path to your private key
    host        = self.public_ip
    timeout     = "2m"
   }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y java-1.8.0-openjdk-devel",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins"
    ]
  }
}

/*
connection {
    type     = "ssh"
    user     = "ubuntu"  # Update with the appropriate username for your AMI
    private_key = file("tf-key-pair.pem")  # Update with the path to your private key
    timeout  = "2m"
    }


   # File provisioner to copy a file from local to the remote EC2 instance
   provisioner "file" {
    source      = "../Flask Application/app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
   }

   provisioner "remote-exec" {
    inline = [
      sudo apt-get update,
      sudo apt install fontconfig openjdk-17-jre,
      java -version,
      sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \ https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
      echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
      https://pkg.jenkins.io/debian-stable binary/ | sudo tee \ /etc/apt/sources.list.d/jenkins.list > /dev/null ,
      sudo apt-get install jenkins,
      sudo systemctl enable jenkins,
      sudo systemctl start jenkins,
      sudo systemctl status jenkins,
    ]     
}

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = "tf-key-pair"  # Replace with the path to your private key
    host        = self.public_ip
   }

*/


# resource "aws_key_pair" "tf-key-pair" {
#   key_name   = "tf-key-pair"
#   public_key = tls_private_key.rsa.public_key_openssh
# }
# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }
# # resource "local_file" "tf-key" {
# #   content  = tls_private_key.rsa.private_key_pem
# #   filename = "tf-key-pair"
# # }
