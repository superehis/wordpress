variable "region" {
  default = "us-east-1"
}


variable "private_cidr" {
  description = "CIDR block for the VPC"
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
}

variable "public_cidr" {
  description = "CIDR block for the VPC"
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.96.0/19"]
}

variable "availability_zone" {
  description = "availability for the VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}