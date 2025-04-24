# Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform

**Project Description:**
This project focuses on deploying a Jenkins application on an AWS server using Terraform. By leveraging Terraform's infrastructure as code capabilities, we aim to automate the setup process for Jenkins, reducing manual effort and ensuring consistency in deployment.Through this project, we will define the necessary AWS resources using Terraform configuration files, including EC2 instances, security groups, and networking components. We'll then utilise Terraform to provision these resources on AWS. Next, we'll write scripts to install and configure Jenkins on the provisioned EC2 instance. These scripts will handle tasks such as installing dependencies, setting up users, and configuring plugins. Finally, we'll execute the Terraform configuration, triggering the deployment process. Once completed, Jenkins will be up and running on the AWS server, ready for use. This automated deployment approach will streamline the setup of Jenkins on AWS, enabling faster deployment, reducing human error, and improving overall efficiency in software development workflows.

**Overview :**   		
![terraform-jenkins-project](https://github.com/user-attachments/assets/c3ddaa0a-0109-4648-bc83-8e7a53a1204f)


**Prerequisites:**
1.	AWS Account: You need an AWS account to access AWS services.
2.	Terraform Installed: Ensure Terraform is installed on your local machine to define and provision AWS resources.
3.	AWS CLI Installed and Configured: Install the AWS Command Line Interface (CLI) and configure it with your AWS credentials.
4.	Basic Understanding of Terraform and AWS: Familiarize yourself with Terraform basics and have a basic understanding of AWS services, particularly VPC, EC2 etc.
5.	IDE: In my opinion, the VS Code Editor stands out as the top pick for an Integrated Development Environment (IDE).

**Steps**

| Step No | Document Link |
| ------ | ------ |
| 1 | [Install the Required Plugins][Step-1] |
| 2 | [Create Resource Configuration Files][Step-2] |
| 3 | [Assigning Values to Resources][Step-3] |
| 4 | [Jenkins Application Deployment][Step-4] |
| 5 | [Retrieving the Instance IP Address as Output][Step-5] |
| 6 | [Deploy the Application][Step-6] |

   [Step-1]: <./Step 1: Install the Required Plugins>
   [Step-2]: <./Step 2: Create Resource Configuration Files>   
   [Step-3]: <./Step 3: Assigning Values to Resources>
   [Step-4]: <./Step 4: Jenkins Application Deployment>
   [Step-5]: <./Step 5: Retrieving the Instance IP Address as Output.md>   
   [Step-6]: <./Step 6 : Deploy the Application>


