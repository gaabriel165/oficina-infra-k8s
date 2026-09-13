variable "region" {
  description = "AWS region to provision into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix applied to all resources"
  type        = string
  default     = "oficina-api"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "oficina-api-eks"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane"
  type        = string
  default     = "1.34"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "node_instance_type" {
  description = "EC2 instance type for the EKS managed node group"
  type        = string
  default     = "t3.small"
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "github_owner" {
  description = "GitHub owner of the four project repositories"
  type        = string
  default     = "gaabriel165"
}

variable "app_repo" {
  description = "Repository of the main application (Kubernetes workload)"
  type        = string
  default     = "oficina-api"
}

variable "k8s_infra_repo" {
  description = "Repository of the Kubernetes infrastructure (this one)"
  type        = string
  default     = "oficina-infra-k8s"
}

variable "db_infra_repo" {
  description = "Repository of the managed database infrastructure"
  type        = string
  default     = "oficina-infra-db"
}

variable "lambda_repo" {
  description = "Repository of the serverless authentication function"
  type        = string
  default     = "oficina-lambda-auth"
}

variable "github_owner_id" {
  description = "Numeric GitHub id of the owner, present in the new OIDC subject format"
  type        = string
  default     = "64619002"
}

variable "repo_ids" {
  description = "Numeric GitHub ids of the repositories, present in the new OIDC subject format"
  type        = map(string)
  default = {
    oficina-api         = "1226887421"
    oficina-infra-k8s   = "1368526430"
    oficina-infra-db    = "1368526513"
    oficina-lambda-auth = "1368526604"
  }
}
