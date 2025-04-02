# Deploying n8n on Civo Using Terraform

## Introduction

[n8n](https://n8n.io/) is a powerful workflow automation tool that enables users to connect various applications and services through a visual, node-based interface. This guide will walk you through deploying n8n on a Civo Kubernetes cluster using Terraform.

## Prerequisites
Before proceeding with the deployment, ensure you have the following prerequisites in place:
1. **Install Git**: To start, you need to have Git installed on your system. You can download the latest version of Git from the [official Git website](https://git-scm.com/downloads). Follow the installation instructions for your operating system:
   * For Windows: Run the installer and follow the prompts.
   * For macOS (using Homebrew): Run `brew install git` in your terminal.
   * For Linux: Run `sudo apt-get install git` (for Ubuntu-based distributions) or `sudo yum install git` (for RPM-based distributions).
2. **Install Terraform**: Terraform is required for infrastructure provisioning. You can download the latest version of Terraform from the [official Terraform website](https://www.terraform.io/downloads). Follow the installation instructions for your operating system:
   * For Windows: Download the binary and add it to your system's PATH.
   * For macOS (using Homebrew): Run `brew install terraform` in your terminal.
   * For Linux: Download the binary and move it to a directory in your system's PATH, such as `/usr/local/bin`.

Once you have git, run `git clone https://github.com/civo-learn/civo-n8n.git`.

## Setting Up Your API Key

Before running Terraform, you need to configure your Civo API key:

1. Log in to your [Civo account](https://www.civo.com/).
2. Navigate to your **Profile** and locate your API key.
3. In your `terraform/lon2` directory, copy the example variables file:

   ```sh
   cp terraform.tfvars.example terraform.tfvars
   ```

4. Open `terraform.tfvars` and replace the placeholder with your actual Civo API key.

## Deployment Steps

To deploy n8n, navigate to the `terraform/lon2` directory and execute the following commands:

```sh
terraform init
terraform plan
terraform apply
```

This will provision the necessary resources and install the n8n application using a Helm chart on your Civo Kubernetes cluster.

## Accessing the Application

Once the deployment is complete, follow these steps to access n8n:

1. Navigate to your Civo Kubernetes cluster in the Civo dashboard.
2. Locate the DNS name of the load balancer created for the deployment.
3. Open your browser and enter the following URL, replacing `<load balancer DNS>` with the actual DNS name:

   ```
   http://<load balancer DNS>:5678
   ```

This will take you to the n8n application interface.

## Further Documentation
For guides on configuring n8n with Relax AI, refer to [relax.ai/docs](https://relax.ai/docs/integrations/n8n).

For detailed guides on configuring and using n8n, refer to the [official n8n documentation](https://docs.n8n.io/).

## Conclusion

By following this guide, you have successfully deployed n8n on Civo using Terraform. You can now start automating workflows and integrating applications seamlessly.
