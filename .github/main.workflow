workflow "Deploy app to AKS" {
  on = "push"
  resolves = ["Deploy to AKS"]
}

action "Load AKS credential" {
  uses = "./azure-cli/"
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
  args = "aks get-credentials -g $AKS_RG_NAME -n $AKS_CLUSTER_NAME -a"
  env = {
    AZ_OUTPUT_FORMAT = "table"
    AKS_RG_NAME = "your-aks-rg"
    AKS_CLUSTER_NAME = "youraks"
  }
}

action "Deploy branch filter" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Deploy to AKS" {
  needs = ["Load AKS credential", "Deploy branch filter"]
  uses = "docker://gcr.io/cloud-builders/kubectl"
  runs = "sh -l -c"
  args = ["cat $GITHUB_WORKSPACE/sampleapp.yaml |  sed -e 's/YOUR_VALUE/'\"$YOUR_VALUE\"'/' -e 's/YOUR_DNS_LABEL_NAME/'$YOUR_DNS_LABEL_NAME'/' | kubectl apply -f - "]
  env = {
    YOUR_VALUE = "Ale"
    YOUR_DNS_LABEL_NAME = "yournamedispvar"
  }
}