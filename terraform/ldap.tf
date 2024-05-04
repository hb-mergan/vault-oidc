resource "vault_ldap_auth_backend" "ldap" {
  description = "LDAP authentication backend"
  path        = "ldap"
  url         = var.ldap_address
  binddn      = var.ldap_binddn
  bindpass    = var.ldap_bindpass
  userdn      = var.ldap_userdn
  userattr    = var.ldap_userattr
  groupdn     = var.ldap_groupdn
  discoverdn  = false
}

