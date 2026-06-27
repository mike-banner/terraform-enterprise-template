# Requirements

## Epic: Base Terraform Enterprise Platform (AWS)
**Goal:** Déployer une Landing Zone AWS robuste, isolée par environnements, et pilotée par du code (IaC) de manière standardisée.

### Core Features

#### Feature 1: Remote State & Locking
- **Description:** Sécurisation du fichier d'état `.tfstate` pour le travail collaboratif et l'intégration CI/CD.
- **Acceptance Criteria:**
  - [ ] Un bucket S3 est configuré avec versioning activé.
  - [ ] Une table DynamoDB est configurée pour le State Locking.

#### Feature 2: Découpage par Couches (Layered Architecture)
- **Description:** Structure granulaire empêchant une couche supérieure de casser une couche inférieure.
- **Acceptance Criteria:**
  - [ ] Dossier `01-network` avec VPC, Subnets publics/privés et NAT Gateway.
  - [ ] Dossier `02-security` pour les rôles IAM communs.
  - [ ] Les couches supérieures lisent les outputs via `terraform_remote_state`.

#### Feature 3: Isolation Multi-Environnements
- **Description:** Chaque environnement (Dev, Staging, Prod) utilise le même code Terraform via l'injection de variables.
- **Acceptance Criteria:**
  - [ ] Fichiers de variables `dev.tfvars`, `staging.tfvars`, `prod.tfvars` disponibles dans chaque couche.

#### Feature 4: Base GitOps Automatisée
- **Description:** L'exécution de Terraform est garantie par le CI/CD.
- **Acceptance Criteria:**
  - [ ] Un workflow (ex: GitHub Actions) génère un `terraform plan` sur les Pull Requests.
