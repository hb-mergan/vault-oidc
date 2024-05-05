resource "nomad_acl_auth_method" "vault" {
  default        = true
  name           = "Vault-SSO"
  type           = "OIDC"
  token_locality = "local"
  max_token_ttl  = "10m0s"

  config {
    oidc_discovery_url = vault_identity_oidc_provider.oidc-provider.issuer
    oidc_client_id     = vault_identity_oidc_client.nomad.client_id
    oidc_client_secret = vault_identity_oidc_client.nomad.client_secret
    oidc_scopes        = ["groups"]
    allowed_redirect_uris = [
      "http://127.0.0.1:4649/oidc/callback",
      "http://127.0.0.1:4646/ui/settings/tokens",
    ]
    list_claim_mappings = {
      "groups" : "roles"
    }
  }
}

