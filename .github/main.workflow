workflow "List Azure Resources" {
  on = "push"
  resolves = ["List Resources"]
}

action "List Resources" {
  uses = "./azure-cli/"
  args = "resource list"
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
  env = {
    AZ_OUTPUT_FORMAT = "table"
  }
}