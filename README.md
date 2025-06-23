# Medusa Backend on AWS ECS using Terraform & GitHub Actions

This project deploys the Medusa.js headless commerce backend on AWS ECS using Fargate with Terraform, and uses GitHub Actions for CI/CD.

## 🚀 Features
- ECS Fargate deployment
- GitHub Actions CI/CD
- ECR container registry
- Dockerized Medusa backend

## 🔧 Usage

### 1. Setup AWS Credentials
Store AWS keys in GitHub Secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

### 2. Deploy Infrastructure
```bash
cd terraform
terraform init
terraform apply
```

### 3. Push to GitHub `main` branch to deploy

## 📹 Video

Please record a Loom/YouTube video explaining:
- Terraform setup
- GitHub Actions flow
- Show deployment working (URL + facecam)
