variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-3"
}

variable "environment" {
  description = "Environment Name (dev, staging, prod)"
  type        = string
}

variable "remote_state_bucket" {
  description = "Name of the S3 bucket storing the Terraform remote state"
  type        = string
}

variable "db_port" {
  description = "The port on which the database accepts connections"
  type        = number
  default     = 5432
}
