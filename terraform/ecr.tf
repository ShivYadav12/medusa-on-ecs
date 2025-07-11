## ecr.tf is just a Terraform file (with .tf extension) that defines AWS Elastic Container Registry (ECR) resources.
resource "aws_ecr_repository" "medusa" {
  name = "${var.project_name}-repo"
}
