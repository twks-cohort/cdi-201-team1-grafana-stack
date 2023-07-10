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

# Create an API Key we can use to push metrics into the stack
resource "grafana_cloud_api_key" "metrics_publisher" {
  provider = grafana.admin
  cloud_org_slug = var.org_name
  name           = "publisher-key"
  role           = "MetricsPublisher"
}

output "metrics_api_key" {
  value     = grafana_cloud_api_key.metrics_publisher.key
  sensitive = true
}

output "metrics_endpoint" {
  value     = grafana_cloud_stack.team_stack.prometheus_remote_write_endpoint
}

output "metrics_username" {
  value     = grafana_cloud_stack.team_stack.prometheus_user_id
}

output "logs_endpoint" {
  value     = grafana_cloud_stack.team_stack.logs_url
}

output "logs_username" {
  value     = grafana_cloud_stack.team_stack.logs_user_id
}

output "traces_endpoint" {
  value     = grafana_cloud_stack.team_stack.traces_url
}

output "traces_username" {
  value     = grafana_cloud_stack.team_stack.traces_user_id
}
