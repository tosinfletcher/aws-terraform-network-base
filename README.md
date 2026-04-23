# AWS Terraform Network Base

This project provides a production-ready, highly available base network infrastructure on AWS using Terraform. It establishes a Virtual Private Cloud (VPC) across three Availability Zones (AZs) with a clear separation between public and private tiers.

## Architecture Overview

The infrastructure consists of the following components:

### 🌐 Network Layer
- **VPC**: A logically isolated section of the AWS Cloud.
- **Public Subnets**: Three public subnets (one per AZ) configured to automatically assign public IPs on launch. These are intended for load balancers, bastion hosts, or public-facing services.
- **Private Subnets**: Three private subnets (one per AZ) for backend services, databases, and application servers that should not be directly accessible from the internet.

### 🚀 Connectivity & Routing
- **Internet Gateway (IGW)**: Enables communication between the VPC and the internet.
- **NAT Gateways**: Three NAT Gateways (one in each public subnet) allowing resources in private subnets to initiate outbound traffic to the internet (e.g., for software updates) while blocking unsolicited inbound connections.
- **Route Tables**:
  - **Public Route Table**: Directs traffic from public subnets to the Internet Gateway.
  - **Private Route Tables**: Directs traffic from each private subnet to its corresponding NAT Gateway in the same AZ for high availability.

### 🛡️ Security
- **Public Security Group**: A pre-configured security group that allows inbound traffic on ports 80 (HTTP) and 443 (HTTPS) from any source and allows all outbound traffic.

## Project Structure

```text
.
├── deploy/
│   ├── network.tf     # Main network resource definitions
│   ├── providers.tf   # Terraform provider and version constraints
│   ├── variable.tf      # Input variables for customization
│
└── README.md           # Project documentation
```

## Getting Started

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/install) installed (v1.14+)
- An AWS account and configured credentials (via `aws configure` or environment variables)

### Provisioning Steps

Follow these steps to deploy the network infrastructure. All commands should be executed from the `deploy/` directory.

1. **Navigate to the deployment directory**
   ```bash
   cd deploy
   ```

2. **Initialize Terraform**
   Initialize the working directory and download the necessary providers.
   ```bash
   terraform init
   ```

3. **Format the Configuration**
   Ensure the code follows Terraform's canonical formatting.
   ```bash
   terraform fmt
   ```

4. **Validate the Configuration**
   Verify that the configuration is syntactically correct and internally consistent.
   ```bash
   terraform validate
   ```

5. **Generate an Execution Plan**
   Preview the resources that Terraform will create, modify, or destroy.
   ```bash
   terraform plan
   ```

6. **Apply the Changes**
   Deploy the infrastructure to AWS.
   ```bash
   terraform apply
   ```
   *You will be prompted to type `yes` to confirm the action.*

## Configuration

You can customize the network using the variables defined in `deploy/variable.tf`. You can provide values via a `.tfvars` file or environment variables.

| Variable | Description | Default Value |
|----------|-------------|----------------|
| `region` | AWS Region to deploy in | `us-east-1` |
| `cidr_block` | CIDR block for the VPC | `10.0.0.0/16` |
| `cidr_public_subnet_1` | CIDR for Public Subnet 1 | `10.0.1.0/24` |
| `cidr_public_subnet_2` | CIDR for Public Subnet 2 | `10.0.2.0/24` |
| `cidr_public_subnet_3` | CIDR for Public Subnet 3 | `10.0.3.0/24` |
| `cidr_private_subnet_1` | CIDR for Private Subnet 1 | `10.0.4.0/24` |
| `cidr_private_subnet_2` | CIDR for Private Subnet 2 | `10.0.5.0/24` |
| `cidr_private_subnet_3` | CIDR for Private Subnet 3 | `10.0.6.0/24` |

## Cleanup

To destroy all resources created by this project:

```bash
terraform destroy
```
