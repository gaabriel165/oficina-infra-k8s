locals {
  github_subjects = {
    for repo, id in var.repo_ids : repo => [
      "repo:${var.github_owner}/${repo}:*",
      "repo:${var.github_owner}@${var.github_owner_id}/${repo}@${id}:*",
    ]
  }
}

module "github_oidc_provider" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = "~> 5.44"
}

module "app_github_actions_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "~> 5.44"

  name     = "${var.project_name}-app-github-actions"
  subjects = local.github_subjects[var.app_repo]

  policies = {
    admin = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  depends_on = [module.github_oidc_provider]
}

module "service_github_actions_role" {
  source   = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version  = "~> 5.44"
  for_each = var.service_repos

  name     = "${each.value}-github-actions"
  subjects = local.github_subjects[each.value]

  policies = {
    admin = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  depends_on = [module.github_oidc_provider]
}

module "k8s_infra_github_actions_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "~> 5.44"

  name     = "${var.project_name}-k8s-infra-github-actions"
  subjects = local.github_subjects[var.k8s_infra_repo]

  policies = {
    admin = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  depends_on = [module.github_oidc_provider]
}

module "db_infra_github_actions_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "~> 5.44"

  name     = "${var.project_name}-db-infra-github-actions"
  subjects = local.github_subjects[var.db_infra_repo]

  policies = {
    admin = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  depends_on = [module.github_oidc_provider]
}

module "lambda_github_actions_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "~> 5.44"

  name     = "${var.project_name}-lambda-github-actions"
  subjects = local.github_subjects[var.lambda_repo]

  policies = {
    admin = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  depends_on = [module.github_oidc_provider]
}
