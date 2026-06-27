variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "project_prefix" {
  description = "Prefix used for all resources"
  type        = string
  default     = "tf-ent-plat"
}
