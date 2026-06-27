---
wave: 1
depends_on: []
files_modified: ["terraform/00-remote-state/main.tf", "terraform/00-remote-state/variables.tf", "terraform/00-remote-state/outputs.tf", "terraform/00-remote-state/providers.tf"]
autonomous: true
---

# Plan 1: AWS Remote State Foundation

## Objective
Créer le backend distant (S3) et le verrouillage de state (DynamoDB) pour les futures couches Terraform.

## Context
Ce plan initialise la couche "00-remote-state". Cette couche est particulière car elle crée le backend utilisé par toutes les autres couches. Son propre `tfstate` devra être conservé précieusement ou géré localement, car le bucket n'existe pas encore au premier "apply".

## Tasks

### 1. Initialiser le projet Terraform 00-remote-state
<read_first>
- terraform/00-remote-state/
- .planning/REQUIREMENTS.md
</read_first>
<action>
Créer le fichier `terraform/00-remote-state/providers.tf` configurant le provider AWS (version >= 5.0). Créer `terraform/00-remote-state/variables.tf` pour définir les variables `aws_region` (défaut: eu-west-3) et `project_prefix`.
</action>
<acceptance_criteria>
- `terraform/00-remote-state/providers.tf` configure le provider `aws`.
- `terraform/00-remote-state/variables.tf` déclare la variable `aws_region` et `project_prefix`.
</acceptance_criteria>

### 2. Créer le Bucket S3 de State
<read_first>
- terraform/00-remote-state/providers.tf
- terraform/00-remote-state/variables.tf
</read_first>
<action>
Créer `terraform/00-remote-state/main.tf` et y ajouter une ressource `aws_s3_bucket` pour stocker les états. Activer le versioning (`aws_s3_bucket_versioning`) et forcer le chiffrement (`aws_s3_bucket_server_side_encryption_configuration` en AES256). Bloquer les accès publics (`aws_s3_bucket_public_access_block`).
</action>
<acceptance_criteria>
- `terraform/00-remote-state/main.tf` contient `aws_s3_bucket`, `aws_s3_bucket_versioning` (status = "Enabled").
- Le bloc d'accès public est configuré (`block_public_acls`, `block_public_policy`, `ignore_public_acls`, `restrict_public_buckets` à true).
</acceptance_criteria>

### 3. Créer la table DynamoDB pour le State Lock
<read_first>
- terraform/00-remote-state/main.tf
</read_first>
<action>
Ajouter dans `terraform/00-remote-state/main.tf` la ressource `aws_dynamodb_table` avec comme Hash Key l'attribut `LockID` (type `S`) et une capacité de type `PAY_PER_REQUEST`.
</action>
<acceptance_criteria>
- La table DynamoDB est déclarée avec `hash_key = "LockID"`.
- L'attribut `LockID` est explicitement défini avec `type = "S"`.
- `billing_mode` est défini sur "PAY_PER_REQUEST".
</acceptance_criteria>

### 4. Exposer les Outputs
<read_first>
- terraform/00-remote-state/main.tf
</read_first>
<action>
Créer `terraform/00-remote-state/outputs.tf` pour exposer le nom du bucket S3 et le nom de la table DynamoDB générés.
</action>
<acceptance_criteria>
- `terraform/00-remote-state/outputs.tf` contient les blocs `output "state_bucket_name"` et `output "dynamodb_table_name"`.
</acceptance_criteria>

## Verification
- L'exécution de `terraform validate` dans `terraform/00-remote-state/` est un succès.
- Les fichiers crées respectent la syntaxe HCL standard.

## Must Haves
- truths: []
