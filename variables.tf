variable "environment_tag" {
  description = "Environment tag"
  default     = "Production"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
