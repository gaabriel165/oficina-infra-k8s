output "region" {
  description = "AWS region"
  value       = var.region
}

output "project_name" {
  description = "Name prefix shared by the other infrastructure repositories"
  value       = var.project_name
}

output "vpc_id" {
  description = "VPC that hosts the cluster, the database and the Lambda"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnets used by worker nodes, RDS and Lambda"
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "Public subnets used by the load balancer"
  value       = module.vpc.public_subnets
}

output "node_security_group_id" {
  description = "Security group of the EKS worker nodes"
  value       = module.eks.node_security_group_id
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "configure_kubectl" {
  description = "Command to point kubectl at the cluster"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"
}

output "ecr_repository_url" {
  description = "ECR repository URL for the application image"
  value       = aws_ecr_repository.app.repository_url
}

output "jwt_secret_parameter_name" {
  description = "SSM parameter holding the shared JWT signing key"
  value       = aws_ssm_parameter.jwt_secret.name
}

output "webhook_secret_parameter_name" {
  description = "SSM parameter holding the webhook shared secret"
  value       = aws_ssm_parameter.webhook_secret.name
}

output "app_github_actions_role_arn" {
  description = "Role assumed by the application repository pipeline"
  value       = module.app_github_actions_role.arn
}

output "k8s_infra_github_actions_role_arn" {
  description = "Role assumed by this repository pipeline"
  value       = module.k8s_infra_github_actions_role.arn
}

output "db_infra_github_actions_role_arn" {
  description = "Role assumed by the database infrastructure pipeline"
  value       = module.db_infra_github_actions_role.arn
}

output "lambda_github_actions_role_arn" {
  description = "Role assumed by the Lambda repository pipeline"
  value       = module.lambda_github_actions_role.arn
}
