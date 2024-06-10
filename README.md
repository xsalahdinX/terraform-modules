
# 🌟 Terraform Modules

## 📜 Overview
This repository contains a collection of reusable Terraform modules designed to simplify the deployment and management of various AWS resources. Each module is self-contained and follows best practices to ensure reliability and ease of use.

### 📥 Cloning the Repository
To get started with these modules, clone the repository using the following command:

```sh
git clone https://github.com/xsalahdinX/terraform-modules.git
```

## 📦 Modules
Below is a list of available modules within this repository:

- [🌐 VPC](./vpc/README.md)
- [🌉 Subnets](./subnets/README.md)
- [🌐 NAT Gateway](./nat-gateway/README.md)
- [📚 Route Tables](./route-tables/README.md)
- [🔧 EKS Cluster](./eks-cluster/README.md)
- [🧩 Addons](./addons/README.md)
- [🚀 EKS](./eks/README.md)
- [🌐 Network](./network/README.md)
- [👥 Nodegroup](./nodegroup/README.md)
- [⚙️ ALB Controller](./alb-controller/README.md)
- [🔒 AWS Auth](./aws-auth/README.md)
- [📊 Charts/AWS Auth](./charts/aws-auth/README.md)
- [🗃️ EFS Controller](./efs-controller/README.md)
- [🔗 Endpoint Gateway](./endpoint-gateway/README.md)
- [🛠️ S3 Addon](./s3-addon/README.md)
- [📂 S3](./s3/README.md)
- [👤 User Roles](./user_roles/README.md)

Each module includes detailed instructions on how to use and customize it for your specific needs.

## 📘 Usage
To use a module, add a module block in your Terraform configuration and specify the source as the path to the module within this repository. For example:

```hcl
module "module_name" {
  source = ""github.com/xsalahdinX/terraform-modules//folder-example"
}
```

## 🤝 Contributing
We welcome contributions to improve and expand the modules. Please open an issue or submit a pull request with your changes.
