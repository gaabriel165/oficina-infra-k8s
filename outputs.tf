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
  description = "ECR repository URL for the service order microservice image"
  value       = aws_ecr_repository.app.repository_url
}

output "service_ecr_repository_urls" {
  description = "ECR repository URL of each other microservice, keyed by repository name"
  value       = { for repo, repository in aws_ecr_repository.service : repo => repository.repository_url }
}

output "oidc_provider_arn" {
  description = "IAM OIDC provider of the cluster, trusted by the pod roles of each microservice (IRSA)"
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider" {
  description = "Issuer of the cluster OIDC provider without the https:// prefix"
  value       = module.eks.oidc_provider
}

output "jwt_secret_parameter_name" {
  description = "SSM parameter holding the shared JWT signing key"
  value       = aws_ssm_parameter.jwt_secret.name
}

output "internal_api_secret_parameter_name" {
  description = "SSM parameter holding the secret of the internal service-to-service routes"
  value       = aws_ssm_parameter.internal_api_secret.name
}

output "app_github_actions_role_arn" {
  description = "Role assumed by the service order microservice pipeline"
  value       = module.app_github_actions_role.arn
}

output "service_github_actions_role_arns" {
  description = "Role assumed by the pipeline of each other microservice, keyed by repository name"
  value       = { for repo, role in module.service_github_actions_role : repo => role.arn }
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
