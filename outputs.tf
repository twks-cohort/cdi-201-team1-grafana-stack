output "service_account_token_management_key" {
  value     = grafana_cloud_stack_service_account_token.management.key
  sensitive = true
}