resource "aws_ecr_repository" "medusa" {
  name = "${var.project_name}-repo"
}
