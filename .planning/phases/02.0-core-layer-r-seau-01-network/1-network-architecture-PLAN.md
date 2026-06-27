---
wave: 1
depends_on: []
files_modified: [
  "terraform/01-network/providers.tf",
  "terraform/01-network/variables.tf",
  "terraform/01-network/main.tf",
  "terraform/01-network/outputs.tf",
  "terraform/01-network/dev.tfvars",
  "terraform/01-network/staging.tfvars",
  "terraform/01-network/prod.tfvars"
]
autonomous: true
---

# Plan 1: Architecture Réseau (VPC)

## Objective
Créer la fondation réseau (VPC, sous-réseaux, NAT Gateway) en utilisant le module officiel AWS, avec une configuration isolée par environnement.

## Context
Ce plan s'appuie sur le backend distant (S3/DynamoDB) créé lors de la Phase 1. Il garantit la séparation Public/Privé et la haute disponibilité sur 2 AZs, tout en optimisant les coûts en désactivant la NAT Gateway sur les environnements non-productifs.

## Tasks

### 1. Configurer le Provider et le Backend S3
<read_first>
- terraform/00-remote-state/outputs.tf
</read_first>
<action>
Créer `terraform/01-network/providers.tf`. Configurer le provider `aws` (version ~> 5.0). Ajouter le bloc `backend "s3"` vide (la configuration exacte du bucket/region sera passée lors du `terraform init`).
</action>
<acceptance_criteria>
- `terraform/01-network/providers.tf` contient le provider `aws` et le bloc `backend "s3" {}`.
</acceptance_criteria>

### 2. Définir les variables et les environnements (tfvars)
<read_first>
- .planning/phases/02.0-core-layer-r-seau-01-network/CONTEXT.md
</read_first>
<action>
Créer `terraform/01-network/variables.tf` avec `aws_region`, `environment`, `vpc_cidr` et `enable_nat_gateway`.
Créer les 3 fichiers `dev.tfvars`, `staging.tfvars`, et `prod.tfvars`. Pour `dev` et `staging`, définir `enable_nat_gateway = false`. Pour `prod`, définir `enable_nat_gateway = true`.
</action>
<acceptance_criteria>
- Les 4 fichiers sont créés avec une syntaxe HCL valide.
- `dev.tfvars` et `staging.tfvars` ont `enable_nat_gateway = false`.
- `prod.tfvars` a `enable_nat_gateway = true`.
</acceptance_criteria>

### 3. Implémenter le VPC via le module officiel AWS
<read_first>
- terraform/01-network/variables.tf
</read_first>
<action>
Créer `terraform/01-network/main.tf`. Utiliser le module `terraform-aws-modules/vpc/aws`. Configurer le module pour utiliser 2 AZs (zones de disponibilité), des sous-réseaux publics et privés. Lier l'activation de la NAT Gateway à la variable `var.enable_nat_gateway`.
</action>
<acceptance_criteria>
- `terraform/01-network/main.tf` instancie le module `vpc`.
- Les attributs `enable_nat_gateway = var.enable_nat_gateway` et `single_nat_gateway = true` sont présents.
</acceptance_criteria>

### 4. Exposer les IDs du réseau
<read_first>
- terraform/01-network/main.tf
</read_first>
<action>
Créer `terraform/01-network/outputs.tf` pour exporter `vpc_id`, `private_subnets`, et `public_subnets` depuis le module VPC, afin que la couche sécurité (Phase 3) puisse s'y attacher.
</action>
<acceptance_criteria>
- `terraform/01-network/outputs.tf` contient les outputs pour le VPC et les subnets.
</acceptance_criteria>

## Verification
- Les 3 environnements peuvent être planifiés correctement si l'on passe les bons paramètres de backend et de tfvars.

## Must Haves
- truths:
  - "D-01: Public & Private subnets split"
  - "D-02: NAT Gateway is dynamic based on environment"
  - "D-03: Network spans 2 Availability Zones"
