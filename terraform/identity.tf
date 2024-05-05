locals {
  groups = ["frontend", "editors", "backend"]
}

resource "vault_identity_group" "group" {
  for_each = toset(local.groups)

  name = each.value
  type = "external"
}

resource "vault_identity_group_alias" "group_alias" {
  for_each = toset(local.groups)

  name           = each.value
  mount_accessor = vault_ldap_auth_backend.ldap.accessor
  canonical_id   = vault_identity_group.group[each.value].id
}

# An OIDC assignment describes the list of the Vault entities and groups allowed to authenticate with this client.
resource "vault_identity_oidc_assignment" "oidc-assignment" {
  name      = "oidc-assignment"
  group_ids = [for key in local.groups : vault_identity_group.group[key].id]
}

resource "vault_identity_oidc_scope" "groups" {
  name        = "groups"
  description = "The groups scope provides the groups claim using Vault group membership"
  template    = <<EOF
  {
    "groups": {{identity.entity.groups.names}}
  }
  EOF
}

# The key is usable by all Vault OIDC clients as allowed_client_ids is set to *. This is not recommended for production.
resource "vault_identity_oidc_key" "oidc-key" {
  name               = "oidc-key"
  allowed_client_ids = ["*"]
  verification_ttl   = 7200
  rotation_period    = 3600
  algorithm          = "RS256"
}

resource "vault_identity_oidc_client" "nomad" {
  name = "nomad"
  redirect_uris = [
    "http://127.0.0.1:4649/oidc/callback",
    "http://127.0.0.1:4646/ui/settings/tokens"
  ]
  assignments = [
    vault_identity_oidc_assignment.oidc-assignment.name
  ]
  key              = vault_identity_oidc_key.oidc-key.name
  id_token_ttl     = 1800
  access_token_ttl = 3600
}

resource "vault_identity_oidc_provider" "oidc-provider" {
  name          = "oidc-provider"
  https_enabled = false
  issuer_host   = "127.0.0.1:8200"
  allowed_client_ids = [
    vault_identity_oidc_client.nomad.client_id
  ]
  scopes_supported = [
    vault_identity_oidc_scope.groups.name
  ]
}
