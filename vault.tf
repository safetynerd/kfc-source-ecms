provider "vault" {
  token = ""
}

data "vault_generic_secret" "ecms-secrets" {
  path = some/path/connector/var.env
}

data "vault_generic_secret" "kafka-secrets" {
  path = some/path/connector/var.env
}