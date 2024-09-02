variable "DB_USERNAME" {
  description = "Database username"
  type        = string
  default     = "petclinic"
  sensitive   = true
}

variable "DB_PASSWORD" {
  description = "Database password"
  type        = string
  default     = "petclinicdbpassword"
  sensitive   = true
}

variable "GRAFANA_PASSWORD" {
  description = "Grafana password"
  type        = string
  sensitive   = true
}