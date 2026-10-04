# terraform-azure-infrastructure
Production-ready Azure infrastructure provisioned using Terraform with reusable modules and Dev/Prod environment separation.

==============================================================================================================================================================

Enterprise-grade, modular Infrastructure as Code (IaC) setup for deploying scalable, secure, and resilient workloads on Microsoft Azure. Built using reusable modules with complete environment parity across `dev` and `prod`.

---

## Architecture Overview

                  +-----------------------------+
                  |      Azure Virtual WAN      |
                  |    Hub & Spoke / VNet       |
                  +--------------+--------------+
                                 |
         +-----------------------+-----------------------+
         |                                               |
         v                                               v
+-----------------+                             +-----------------+
|   Dev Spoke     |                             |   Prod Spoke    |
| - App Subnet    |                             | - App Subnet    |
| - DB Subnet     |                             | - DB Subnet     |
| - NSG / Bastion |                             | - Private Link  |
+-----------------+                             +-----------------+

### Core Features

- **Multi-Environment Architecture:** Dedicated directory isolation between `dev` and `prod` with independent state files and `.tfvars`.
- **Reusable Core Modules:** Parameterized modules for Networking, Compute, Database, and Security.
- **Security-First Approach:** Default private endpoints, strict Network Security Group (NSG) rules, zero public IP exposure for databases, and Azure Key Vault integration.
- **Remote State Locking:** Integrated with Azure Blob Storage backend using Blob Leases to prevent concurrent deployment drift.

---

## Repository Structure

```text
.
├── modules/                      # Reusable modules (building blocks)
│   ├── networking/               # VNet, Subnets, Route Tables, NSGs
│   ├── compute/                  # Virtual Machines, Scale Sets, or AKS
│   ├── database/                 # Azure Database (SQL / PostgreSQL Flexible Server)
│   └── security/                 # Key Vault, Secrets, Managed Identities
│
├── environments/                 # Root configurations per environment
│   ├── dev/
│   │   ├── main.tf               # Module invocations for dev
│   │   ├── variables.tf          # Input variable declarations
│   │   ├── outputs.tf            # Exported endpoints & IDs
│   │   ├── terraform.tfvars      # Dev-specific variable values
│   │   └── backend.tf            # Dev remote state configuration
│   └── prod/
│       ├── main.tf               # Module invocations for prod (HA/SLA focus)
│       ├── variables.tf
│       ├── outputs.tf
│       ├── terraform.tfvars      # Production SKUs & sizing
│       └── backend.tf            # Prod remote state configuration
│
├── .gitignore
└── README.md
Deep Dive: How the Modules WorkInfrastructure logic is broken into isolated, plug-and-play modules inside modules/. Each module accepts standard input variables and exposes outputs that downstream modules consume.1. modules/networkingKaam: Poora network topology provision karta hai.Components: Virtual Network (VNet), application/database subnets, Network Security Groups (NSGs), aur Route Tables.Inter-module Connection: Yeh module subnet_ids aur vnet_id output karta hai, jise compute aur database modules consumption ke liye use karte hain.2. modules/computeKaam: Virtual Machines, Scale Sets (VMSS), ya AKS clusters launch karta hai.Workflow:networking module se app_subnet_id leta hai.Compute instances ko launch karke security module ke through Managed Identity assign karta hai taaki direct secrets hardcode na karne padein.3. modules/databaseKaam: Managed database instances (e.g., Azure PostgreSQL Flexible Server ya Azure SQL) provision karta hai.Private Access: Database ko public internet se block rakha jata hai aur networking module ke db_subnet_id me Private Endpoint / VNet Integration ke sath attach kiya jata hai.4. modules/securityKaam: Azure Key Vault, Access Policies/RBAC, aur secrets management handle karta hai.Workflow: Database passwords, TLS certificates, aur sensitive tokens yahan automatically generate ya store hote hain, jise compute layers bina code exposure ke retrieve kar sakti hain.Module Data Flow[ networking ] ----( subnet_ids )----+----> [ compute ]
                                     |           |
                                     |      ( Managed ID )
                                     v           v
                                [ database ] <---+----> [ security (Key Vault) ]
                                      ^                      |
                                      +---( stores secrets )-+
PrerequisitesTerraform CLI (>= 1.5.0)Azure CLI (>= 2.50.0)Active Azure Subscription with Owner or Contributor roleQuick Start1. Azure AuthenticationLogin to Azure and select your subscription:Bashaz login
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
2. Configure Remote BackendCreate an Azure Storage Account to store your .tfstate files:BashRESOURCE_GROUP="rg-terraform-tfstate"
STORAGE_ACCOUNT="tfstate$(openssl rand -hex 4)"
CONTAINER_NAME="tfstate"

az group create --name $RESOURCE_GROUP --location centralindia
az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --sku Standard_LRS --encryption-services blob
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT
Update environments/<target>/backend.tf with your storage values:Terraformterraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-tfstate"
    storage_account_name = "<STORAGE_ACCOUNT_NAME>"
    container_name       = "tfstate"
    key                  = "terraform.<env>.tfstate"
  }
}
3. Deploy InfrastructureNavigate to the target environment directory:Bashcd environments/dev

# 1. Initialize providers & backend
terraform init

# 2. Check configuration syntax
terraform validate

# 3. Preview resource changes
terraform plan -var-file="terraform.tfvars"

# 4. Apply changes
terraform apply -var-file="terraform.tfvars"
Environment ComparisonDimensionDevelopment (dev)Production (prod)High AvailabilitySingle zone, standard storageMulti-zone redundancy (ZRS), Premium SSDCompute SizingBurstable instances (e.g., Standard_B2s)Compute/Memory optimized (e.g., Standard_D4s_v5)Data ProtectionSoft delete enabled, short retentionAutomated geo-redundant backups, 30-day retentionNetwork SecurityOptional bastion/jump hostStrict private endpoints & Hub-Spoke isolationContributing & Best PracticesRun terraform fmt -recursive before creating a pull request.Ensure terraform validate runs cleanly inside both dev/ and prod/.Keep all modules fully parameterized—never hardcode resource IDs, subscription IDs, or IP CIDRs directly inside modules/.
