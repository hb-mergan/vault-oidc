resource "nomad_acl_role" "frontend-role" {
  name        = "frontend-role"
  description = "custom frontend role"

  policy {
    name = nomad_acl_policy.frontend-policy.name
  }
}

resource "nomad_acl_role" "editors-role" {
  name        = "editors-role"
  description = "custom editors role"

  policy {
    name = nomad_acl_policy.editors-policy.name
  }

  policy {
    name = nomad_acl_policy.frontend-policy.name
  }
}

resource "nomad_acl_role" "backend-role" {
  name        = "backend-role"
  description = "custom backend role"

  policy {
    name = nomad_acl_policy.backend-policy.name
  }
}
