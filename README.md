# cicd_terraform_project
# my-aks-terraform-ci-cd
# PROJECT STRUCTURE
#
<!-- CLOUDCICD/
└── terraform/
    ├── main.tf                  # Updated to target specific resource group
    ├── variables.tf             # Variables updated for resource group scope
    ├── outputs.tf
    ├── terraform.tfvars         # Ensure resource group name and location are specified
    ├── scripts/
    │   ├── install-jenkins.sh
    │   ├── monitor-hpa.sh
    │   ├── benchmark-hpa.sh
    ├── modules/
        ├── vm/
        │   ├── main.tf          # Resources in VM module scoped to resource group
        │   ├── variables.tf
        │   ├── outputs.tf
        ├── aks/
        │   ├── main.tf          # Resources in AKS module scoped to resource group
        │   ├── variables.tf
        │   ├── outputs.tf
        ├── keyvault/
        │   ├── main.tf          # Resources in Key Vault module scoped to resource group
        │   ├── variables.tf
        │   ├── outputs.tf
        ├── acr/
        │   ├── main.tf          # Resources in ACR module scoped to resource group
        │   ├── variables.tf
        │   ├── outputs.tf
└── application/
    ├── app.py
    ├── Dockerfile
    ├── requirements.txt
    ├── k8s/
        ├── deployment.yaml
        ├── service.yaml
        ├── ingress.yaml
        ├── hpa.yaml -->

# Automated Infrastructure and CI/CD Pipeline Deployment with Terraform using Azure

This project provides a fully automated solution for deploying and managing an end-to-end infrastructure and CI/CD pipeline using Azure and Terraform. It provisions necessary cloud resources, configures a CI/CD pipeline, and deploys a containerized web application on Azure Kubernetes Service (AKS).

The solution integrates security, scalability, and orchestration by leveraging Azure Key Vault, Cert Manager, NGINX Ingress Controller, HPA, and more.


# Project Objective
=> Automate infrastructure provisioning:
=> Virtual Machine (VM) with Jenkins, Docker, and Git
=> AKS cluster with workload identity and static IP for ingress
=> Integration with Azure Key Vault for secret management
=> Deploy Redis Sentinel and Cert Manager
=> Set up Horizontal Pod Autoscaler (HPA) for CPU and memory

# Containerize and deploy a web application:
=> Develop or clone a simple web app
=> Build and push a container image to Azure Container Registry (ACR)
=> Deploy the application to AKS using Jenkins pipelines

# Ensure continuous integration and delivery (CI/CD):
=> Automate the build, push, and deployment process using Jenkins

# Performance testing:
=> Benchmark the application to verify HPA functionality

# PROJECT REQUIREMENT
# Access Requirements:

Azure subscription with sufficient permissions to deploy resources in a dedicated resource group (<Idowu-Candidate>-CANDIDATE_RG).

# Installed Tools:

- Terraform
- Azure CLI
- Jenkins
- Docker
- Text editor (e.g., VS Code)

# Authentication:

=> Authenticate with Azure using az login.

# Deployment Steps

Step 1: Provision Infrastructure
# Clone the repository:


=> git clone https://github.com/idnoble33/my-aks-terraform-ci-cd.git
=> cd terraform
# Initialize Terraform:

=> terraform init

# Validate Terraform configuration:

terraform validate

# Plan the deployment:

=> terraform plan -var="subscription_id=<your_subscription_id>"

# Apply the changes:

=> terraform apply -var="subscription_id=<your_subscription_id>"

# Verify the deployed resources:

=> Jenkins VM: Provisioned and configured with Docker and Git.
=> AKS Cluster: Set up with 1 node pool.
=> Azure Key Vault: Integrated with AKS for secret injection.
=> ACR: Ready to store container images.

Step 2: Containerize and Deploy Web Application
1. Navigate to the docker/ folder and build the Docker image:

=>  docker build -t <acr_name>.azurecr.io/webapp:v1 .
2. Push the Docker image to ACR:

=> docker push <acr_name>.azurecr.io/webapp:v1

# CI/CD Pipeline with Jenkins

=>  The Jenkinsfile in the ci_cd/ directory defines the pipeline stages:
1. Build and Test: Builds Docker images and runs tests.
2. Push to ACR: Pushes the built images to Azure Container Registry.
3. Deploy to AKS: Deploys the containerized application to AKS using kubectl.

# Automation with Ansible

=> Ansible automates Jenkins configuration and ensures the pipeline setup is ready to execute:
=> Dynamically updates inventory (inventory.ini) with Terraform output.
=> Configures Jenkins with required tools like Docker, Azure CLI, and kubectl.



Step 4: Verify Horizontal Pod Autoscaler (HPA)
1. Stress test the application using a benchmarking tool like Apache Benchmark (ab):

=> ab -n 1000 -c 100 http://<application_url>/

2. Monitor HPA functionality to ensure that pods scale up/down based on resource usage.

# Cleanup
To destroy all resources, run:


=> terraform destroy -var="subscription_id=<your_subscription_id>"



