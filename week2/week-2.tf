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
