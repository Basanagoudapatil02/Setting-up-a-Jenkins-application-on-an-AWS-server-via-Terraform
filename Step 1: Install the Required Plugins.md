**Step 1: Install the Required Plugins** 
1.	Create a new directory in your IDE and navigate to it.
2.	Inside this directory, create a new file named [provider.tf](https://github.com/Basanagoudapatil02/Setting-up-a-Jenkins-application-on-an-AWS-server-via-Terraform/blob/main/provider.tf)
3.	Add the following code to specify the AWS provider and desired region:

```bash  
provider "aws"{
    region = var.region
}
```
4.	Open the terminal, navigate to your project directory, and run the following command: 

```bash
terraform init
```
5.	Running terraform init will install the necessary plugins and modules required for connecting to AWS and managing your infrastructure.


![image](https://github.com/user-attachments/assets/7c50ac09-5e8a-46eb-9016-02316307c355)

