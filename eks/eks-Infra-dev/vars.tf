variable "env" {
  type        = string
  default     = "dev"
  description = "Dev Env"
}

variable "k8s-ver" {
  default     = "1.27"
  description = "K8s Version"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Dev Region"
}

# variable "access_key" {
#   type        = string
#   default     = ""
#   description = "Access key"
# }

# variable "secret_key" {
#   type        = string
#   default     = ""
#   description = "Secret key"
# }