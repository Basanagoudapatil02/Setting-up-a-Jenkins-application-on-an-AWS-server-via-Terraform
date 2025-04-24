 After completing Step 3, the next step is to deploy the Jenkins application source code.
 
1.	Begin by creating a new directory dedicated to your application setup. Within this directory, create a file named install-jenkins.sh.

2.	Copy the contents of [install-jenkins.sh](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Jenkins%20Application/install-jenkins.sh) from the repository and paste them into your new file.

3.	In this example, the script is tailored for deploying Jenkins, but you can modify it to suit your specific application requirements.

4.	Since Jenkins requires Java and other dependencies, these installation steps are included in the shell script.

5.	Reference the path to this shell script in the user_data section of your ec2.tf configuration to automate the setup during EC2 instance provisioning.
   
This approach ensures that all necessary packages are installed and Jenkins is configured automatically as part of your infrastructure deployment.

![image](https://github.com/user-attachments/assets/2eedbe67-b63a-4a67-bccd-2066f9322605)
