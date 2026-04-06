# Raven

Raven delivers messages swiftly and reliably — an async email service built on queues and serverless compute.

## Current infrastructure

Infrastructure is defined with **Terraform** and the **HashiCorp AWS provider** (`~> 6.0`). Each stack configures the AWS provider to **assume an IAM role** and apply **default tags** (`Project`, `Environment`) from variables. Set **role ARN**, **region**, and any **backend** settings via non-committed configuration (for example `*.tfvars` or partial backend config); see `.gitignore`.

### Remote state bucket (`00-remote-backend`)

Bootstrap stack that creates the **S3 bucket** used for remote Terraform state in the other directories:

- **Versioning** enabled on the state bucket.
- **Outputs**: S3 bucket id and bucket name.

This stack uses **local state** (no remote backend) until the bucket exists. Apply it first.

### Networking (`01-networking`)

VPC with **public and private subnets** across **two availability zones**, an **internet gateway**, a **NAT gateway** (with an Elastic IP) in the public tier, and **route tables** so public subnets use the IGW and private subnets use the NAT for outbound traffic. Subnet layout, CIDRs, names, and AZs are driven by variables.

State for this stack is stored in **S3** with a dedicated state key and lockfile; exact `backend` values live in `main.tf` and should be aligned with your account and bucket.

### EKS cluster (`02-eks-cluster`)

**Amazon EKS** control plane and a **managed node group** in the **private subnets** from networking. Private subnets are resolved with a **data source** that matches the same `Project` / `Environment` tags and **private** subnet behavior (`map-public-ip-on-launch` false), so tags on subnets must stay consistent with `default_tags`.

- Cluster **Kubernetes version** and **access config** (`API_AND_CONFIG_MAP`) are defined in Terraform.
- **Cluster and node IAM roles** use the standard AWS managed policies for EKS control plane and worker nodes (including CNI and ECR read-only).
- **Node group**: on-demand capacity; instance type and scaling bounds are set in Terraform (see `eks.cluster.node-group.tf`).

State is stored in **S3** with its own state key; configure the backend to match your remote state bucket and region.

## Repository layout

| Path | Purpose |
| ---- | ------- |
| `00-remote-backend/` | S3 bucket for Terraform remote state. |
| `01-networking/` | VPC, subnets, gateways, NAT, routing. |
| `02-eks-cluster/` | EKS cluster, node group, and IAM for both. |

## Usage

1. **`00-remote-backend`**: `terraform init`, `plan`, `apply` (local state until the bucket exists).
2. **`01-networking`**: `terraform init` with the S3 backend, then `plan` / `apply`.
3. **`02-eks-cluster`**: same as networking after subnets and tags exist.

Do not commit secrets or environment-specific identifiers in `*.tfvars` or backend config files ignored by git.

## License

See `LICENSE` in the repository root.
