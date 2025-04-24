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


