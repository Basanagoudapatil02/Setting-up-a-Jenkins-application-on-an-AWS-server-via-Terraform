1.	Before going to do this step , We have to look at the below code

[vpc.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/vpc.tf)
```bash
resource "aws_vpc" "customvpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "Custom vpc"
  }
}
```
[Internet-gateway.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/Internet-gateway.tf)

```bash
resource "aws_internet_gateway" "custominternetgateway" {
  vpc_id = aws_vpc.customvpc.id
}
```
[subent.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/subent.tf)

```bash
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.customvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = var.subnet_az
  map_public_ip_on_launch = true # It means use subnet for instance launch
}
```
[routetable.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/routetable.tf)

```bash
resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.customvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custominternetgateway.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.publicrt.id
}
```

[ec2.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/ec2.tf)
```bash
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
  user_data = file("${path.module}/../Jenkins_Application/install-jenkins.sh")

    tags = {
      Name = "jenkins"
    }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
}
```

[security-group.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/security-group.tf)

```bash
resource "aws_security_group" "JenkinsSg" {
  name        = "JenkinsSecurityGroup"
  description = "Security group for Jenkins server"

  vpc_id = aws_vpc.customvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
    description = "Custom TCP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JenkinsSecurityGroup"
  }
}
```

[output.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/output.tf)

```bash
output "instance_public_ip" {
  value = aws_instance.server.public_ip
}
```

[variables.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/variables.tf)

```bash
variable "region" {
    description = "AWS region"
    default = "us-east-1"
}

variable "instance_type" {
    description = "Value for Instance type"
}

variable "ami_id" {
    description = "Value for ami-id"
}

variable "sg-name" {
    description = "Name for Security group"
}

variable "vpc-cidr" {
    description = "Value for cidr"
    
}

variable "subnet_az" {
    description = "Value for Availabilty zone of subnet"
}
```
[terraform.tfvars](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/terraform.tfvars)

```bash
region = "us-east-1"
ami_id = "ami-0e86e20dae9224db8" # Enter your ami id 
instance_type = "t2.micro" # Enter the instance type
sg-name = "Jenkins-sg" # Enter your security group name
subnet_az = "us-east-1a" # Enter your az
vpc-cidr = "10.0.0.0/16" # Enter the cidr for vpc
```
[terra-key-ec2.pub](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/terra-key-ec2.pub)
```bash
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAASF4ERVA6IB1gPmz8hyWRQDQHIjcwefsdfvsdjfnfa0GPXKvrZU1tLbak/JG/y9zb2 
```

2.	The above codes are we used to create a EC2 Instance.

3.	Look at the installing Jenkins section :

[install-jenkins.sh](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Jenkins_Application/install-jenkins.sh)
```bash
#!/bin/bash
# Update package index
sudo apt-get update -y

# Install OpenJDK 17 (Java) - required for Jenkins
sudo apt-get install -y openjdk-17-jre

# Add Jenkins repository key and source list
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index again after adding Jenkins repo
sudo apt-get update -y

# Install Jenkins
sudo apt-get install -y jenkins

# Enable Jenkins service to start on boot and start it now
sudo systemctl enable jenkins
sudo systemctl start jenkins
```

3.	Run the below command to know what is going to be created :
```bash
terraform plan
```

8.	Then run the below command for deploy the application :
```bash
terraform apply -auto-approve
```

![image](https://github.com/user-attachments/assets/8fb95295-2f1a-4401-be8e-a84ed3c1678c)

9.	The above command will deploy the application and give the instance’s IP address as output.

![image](https://github.com/user-attachments/assets/00e3df71-2c32-4fec-92f8-77976828a46e)

10.	Copy the generated instance’s IP address from the output and paste it into your web browser with port 8080.

![image](https://github.com/user-attachments/assets/f66c49d8-60bc-4d53-a135-d69d7f043949)

