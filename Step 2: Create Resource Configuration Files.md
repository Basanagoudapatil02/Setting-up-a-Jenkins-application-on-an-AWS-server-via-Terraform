1.	Copy the required resource files from the [repository](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/tree/main/Application%20Infrastructure) and add them to your project directory.
2.	For clarity and maintainability, create a separate .tf file for each major resource or logical group of resources, rather than combining all resources into a single file. This modular approach makes your configuration easier to manage and update as your infrastructure grows.
3.	Customize each resource file as needed to fit your project requirements.
4.	Copy the variable.tf file from the repository and save it as [variables.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/Application%20Infrastructure/variables.tf) in your project directory. This file will contain all input variable definitions for your configuration.
5.	Your project folder should now reflect a well-organized structure, with separate files for providers, resources, variables, and variable values.
6.	Remember, no values are hardcoded in the resource files; all variable values will be provided in the next step using the terraform.tfvars file.

This approach follows Terraform best practices for file organization, making your infrastructure code more readable, reusable, and easier to maintain. 

![image](https://github.com/user-attachments/assets/4aafcef7-0611-439f-9c7f-d9f9bb8da7bf)


![image](https://github.com/user-attachments/assets/24a7abb7-affb-4377-bd41-5c38e58b4a9c)
