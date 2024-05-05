# vault-nomad-oidc-ldap

#### This setup involves:

- Vault: OIDC provider
- Nomad: Confidential OIDC client
- OpenLDAP: Directory service for managing user and group information

#### Repository Structure

- **.env.sample, .envrc.sample**: Sample environment files to set up necessary environment variables.
- **docker-compose.yml**: Docker Compose file to spin up the services.
- **ldap/**: Directory containing LDIF files to setup LDAP organizational units, users, and groups.
- **terraform/**: Contains Terraform configurations for setting up Vault, LDAP authentication, and Nomad ACLs.