data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "env:/${var.environment}/network/terraform.tfstate"
    region = var.aws_region
  }
}
