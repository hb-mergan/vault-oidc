locals {
  roles = ["frontend", "editors", "backend"]
}

resource "nomad_acl_binding_rule" "acl_binding_rule" {
  for_each = toset(local.roles)

  description = "custom ${each.value} binding rule"
  auth_method = nomad_acl_auth_method.vault.name
  bind_type   = "role"
  bind_name   = "${each.value}-role"
  selector    = "${each.value} in list.roles"
}
