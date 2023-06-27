#!/usr/bin/env bats

@test "Ensure grafana stack $TENANT" {
  run bash -c 'curl -L -H "Authorization: Bearer '${GRAFANA_CLOUD_API_KEY}'" https://grafana.com/api/orgs/'${ORG_NAME}'/instances'
  [[ "${output}" =~ '"name": "'${STACK_NAME}'"' ]]
}

@test "evaluate grafana cloud tenant $TENANT" {
  run bash -c 'curl -L -H "Authorization: Bearer '${API_KEY}'" https://'${STACK_SLUG}'.grafana.net/api/datasources'
  [[ "${output}" =~ "prometheus" ]]
}