variable "username" {
  type    = list(any)
  default = ["devoloper1", "webadmins"]
}
/*
variable "developers" {
  type    = list(string)
  description = "List of developer1 usernames"
}
variable "admins" {
  type    = list(string)
  description = "List of webadmins usernames"
}
*/

variable "env" {
  type    = list(any)
  default = ["Development", "Production"]
}

variable "tags" {
  type = map(string)
  default = {
    Env = "Production"
  }
}