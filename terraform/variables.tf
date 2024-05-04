variable "ldap_address" {
  type        = string
  description = "The address of the LDAP server"
}

variable "ldap_binddn" {
  type        = string
  description = "The bind DN for the LDAP server"
}

variable "ldap_bindpass" {
  type        = string
  description = "The bind password for the LDAP server"
  sensitive   = true
}

variable "ldap_userdn" {
  type        = string
  description = "The user DN for the LDAP server"
}

variable "ldap_userattr" {
  type        = string
  description = "The user attribute for the LDAP server"
}

variable "ldap_groupdn" {
  type        = string
  description = "The group DN for the LDAP server"
}
