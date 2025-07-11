### provider.tf is a Terraform configuration file where you define the cloud provider (like AWS, Azure, GCP) your infrastructure will be created on.
provider "aws" {
  region = var.aws_region
}
