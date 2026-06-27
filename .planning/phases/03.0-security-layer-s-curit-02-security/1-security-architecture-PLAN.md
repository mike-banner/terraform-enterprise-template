---
wave: 1
depends_on: []
files_modified: [
  "terraform/02-security/providers.tf",
  "terraform/02-security/variables.tf",
  "terraform/02-security/data.tf",
  "terraform/02-security/main.tf",
  "terraform/02-security/outputs.tf",
  "terraform/02-security/dev.tfvars",
  "terraform/02-security/staging.tfvars",
  "terraform/02-security/prod.tfvars"
]
autonomous: true
---

# Plan 1: Architecture de Sécurité (IAM & Security Groups)

## Objective
Mettre en place les rôles IAM transverses et les règles de pare-feu (Security Groups) avec une architecture 3-tiers (ALB -> App -> DB).

## Context
La couche de sécurité (`02-security`) doit s'attacher au réseau créé dans la couche précédente (`01-network`). On utilisera le `terraform_remote_state` pour récupérer dynamiquement le `vpc_id` sans le coder en dur. L'approche 3-tiers garantit que la base de données ne peut être contactée que par l'application, et l'application uniquement par le Load Balancer.

## Tasks

### 1. Configurer le Provider et les Variables
<read_first>
- terraform/01-network/variables.tf
</read_first>
<action>
Créer le répertoire `terraform/02-security/`.
Créer `terraform/02-security/providers.tf` avec le provider `aws` et le backend `s3`.
Créer `terraform/02-security/variables.tf` avec `aws_region`, `environment`, et `remote_state_bucket`.
Créer les fichiers `dev.tfvars`, `staging.tfvars`, `prod.tfvars` avec les variables d'environnement appropriées.
</action>
<acceptance_criteria>
- Les fichiers providers.tf, variables.tf et les 3 .tfvars sont créés.
</acceptance_criteria>

### 2. Importer le Remote State (VPC ID)
<read_first>
- terraform/01-network/outputs.tf
</read_first>
<action>
Créer `terraform/02-security/data.tf`. Utiliser la data source `terraform_remote_state` nommée `network` pour aller lire le backend S3 de la couche réseau (en utilisant `var.remote_state_bucket` et le chemin attendu `env:/${var.environment}/network/terraform.tfstate`).
</action>
<acceptance_criteria>
- `data.tf` contient un bloc `data "terraform_remote_state" "network"`.
</acceptance_criteria>

### 3. Créer les Security Groups (3-Tiers)
<action>
Créer `terraform/02-security/main.tf`.
Créer 3 ressources `aws_security_group` :
1. `alb_sg` : Ingress 80 et 443 depuis `0.0.0.0/0`.
2. `app_sg` : Ingress sur un port applicatif (ex: 3000 ou 8080) avec comme `security_groups` l'ID du `alb_sg`.
3. `db_sg` : Ingress sur le port `5432` (Postgres) avec comme `security_groups` l'ID du `app_sg`.
Leur associer le `vpc_id = data.terraform_remote_state.network.outputs.vpc_id`. Egress ouvert à `0.0.0.0/0` pour tous.
</action>
<acceptance_criteria>
- Les 3 groupes de sécurité s'enchaînent correctement (ALB -> App -> DB).
- Ils utilisent le VPC ID récupéré dynamiquement.
</acceptance_criteria>

### 4. Créer le rôle IAM applicatif
<action>
Ajouter dans `terraform/02-security/main.tf` un rôle IAM d'exécution applicatif de base (`aws_iam_role` pour `ecs-tasks.amazonaws.com` ou `ec2.amazonaws.com`). Attacher la politique AWS gérée `CloudWatchLogsFullAccess` ou équivalent minimaliste pour les logs.
</action>
<acceptance_criteria>
- Un rôle IAM est défini avec sa `assume_role_policy` et une politique attachée.
</acceptance_criteria>

### 5. Exposer les IDs
<action>
Créer `terraform/02-security/outputs.tf` pour exporter les IDs des 3 Security Groups et l'ARN du rôle IAM, pour que la couche applicative (Phase 4) puisse les utiliser.
</action>
<acceptance_criteria>
- Les outputs `alb_sg_id`, `app_sg_id`, `db_sg_id` et `app_iam_role_arn` sont définis.
</acceptance_criteria>

## Verification
- Les Security Groups doivent former une chaîne fermée.

## Must Haves
- truths:
  - "D-01: 3-Tiers Security Groups isolation"
  - "D-02: App Execution IAM Role creation"
  - "D-03: Dependency on 01-network remote state"
