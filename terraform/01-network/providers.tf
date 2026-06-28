# =============================================================================
# PROVIDER — Cloud cible de cette infrastructure
# =============================================================================
#
# Actuellement configuré pour AWS. Pour changer de cloud, remplacer le bloc
# required_providers et le bloc provider ci-dessous.
#
# SOUVERAINETÉ EUROPÉENNE — alternatives recommandées :
#
#   Scaleway (France) :
#     source  = "scaleway/scaleway"
#     version = "~> 2.0"
#     provider "scaleway" { zone = "fr-par-1" }
#     Docs : https://registry.terraform.io/providers/scaleway/scaleway
#
#   OVHcloud (France) :
#     source  = "ovh/ovh"
#     version = "~> 0.40"
#     provider "ovh" { endpoint = "ovh-eu" }
#     Docs : https://registry.terraform.io/providers/ovh/ovh
#
#   Hetzner (Allemagne, RGPD-friendly) :
#     source  = "hetznercloud/hcloud"
#     version = "~> 1.0"
#     provider "hcloud" { token = var.hcloud_token }
#     Docs : https://registry.terraform.io/providers/hetznercloud/hcloud
#
#   Azure (avec région Europe) :
#     source  = "hashicorp/azurerm"
#     version = "~> 3.0"
#     provider "azurerm" { features {} }
#     → Choisir location = "West Europe" ou "France Central"
#
# NOTE : si tu changes de cloud, le backend (état Terraform) change aussi.
#   AWS  → backend "s3" (configuré ci-dessous)
#   Scaleway → backend "s3" compatible (Object Storage Scaleway)
#   OVH  → backend "s3" compatible (Swift ou OVH Object Storage)
#   Azure → backend "azurerm"
#   GCS   → backend "gcs"
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}
