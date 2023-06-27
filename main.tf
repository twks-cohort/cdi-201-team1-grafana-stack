#Create the stack to use
resource "grafana_cloud_stack" "team_stack" {
  provider = grafana.admin

  name        = var.stack_name
  slug        = var.stack_slug
  region_slug = "us"
  description = "Initial Team stack"
}

# Create a service account we can use to manage the stack
resource "grafana_cloud_stack_service_account" "management" {
  provider = grafana.admin

  stack_slug  = grafana_cloud_stack.team_stack.slug
  name        = var.sa_name
  role        = "Admin"
  is_disabled = "false"
}

# Create a token we can use in the future to login as this account
resource "grafana_cloud_stack_service_account_token" "management" {
  provider = grafana.admin

  stack_slug         = grafana_cloud_stack.team_stack.slug
  name               = var.sa_token_name
  service_account_id = grafana_cloud_stack_service_account.management.id
}

