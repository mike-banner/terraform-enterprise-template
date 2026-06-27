# Project Roadmap

## Phase 1.0: Foundation - Remote State Setup
**Focus:** Mise en place du "Bootstrap" pour stocker les états Terraform.
**Scope:**
- Création du Bucket S3 (Versioning, Encryption).
- Création de la table DynamoDB (LockID).
- Vérification que tous les sous-dossiers peuvent se brancher à ce backend.

## Phase 2.0: Core Layer - Réseau (01-network)
**Focus:** Créer le VPC générique qui hébergera les ressources.
**Scope:**
- Création du module Terraform pour le VPC et les sous-réseaux (Public/Private).
- Implémentation de `dev.tfvars`, `staging.tfvars`, `prod.tfvars`.
- Application sur la couche `01-network/`.

## Phase 3.0: Security Layer - Sécurité (02-security)
**Focus:** Déploiement des fondations IAM et Security Groups transverses.
**Scope:**
- Branchement du `remote_state` pour lire les IDs du VPC.
- Création des Rôles IAM génériques.
- Déploiement multi-environnements.

## Phase 4.0: GitOps CI/CD Integration
**Focus:** Automatisation de l'infrastructure as code.
**Scope:**
- Création du workflow YAML pour exécuter `terraform fmt`, `validate` et `plan` sur chaque Pull Request.
