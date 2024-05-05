resource "nomad_acl_policy" "frontend-policy" {
  name        = "frontend-policy"
  description = "custom frontend policy"

  rules_hcl = <<EOT
namespace "default" {
  policy = "read"
}

node {
  policy = "read"
}
EOT
}

resource "nomad_acl_policy" "editors-policy" {
  name        = "editors-policy"
  description = "custom editors policy"

  rules_hcl = <<EOT
node {
  policy = "write"
}
EOT
}

resource "nomad_acl_policy" "backend-policy" {
  name        = "backend-policy"
  description = "custom backend policy"

  rules_hcl = <<EOT
namespace "default" {
  capabilities = ["submit-job"]
}
EOT
}
