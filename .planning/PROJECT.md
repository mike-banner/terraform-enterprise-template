# Project: Terraform Enterprise Platform Template

## Context
**What This Is:** Un template d'infrastructure AWS (Landing Zone) générique, réutilisable et prêt pour la production (multi-environnements).
**Why It Exists:** Créer un standard d'entreprise pour les futurs projets, démontrer une maîtrise complète du Cloud/Platform Engineering (AWS, Remote State, Isolation), et remplacer la gestion manuelle par une approche GitOps stricte.
**Core Value:** Déploiement standardisé, sécurisé et reproductible. Séparation forte entre les modules réutilisables (génériques) et les configurations spécifiques (Live).

## Current State
**v1.0 (Shipped: 2026-06-28):** Base de l'infrastructure Enterprise.
- **00-remote-state**: Sécurisation des états Terraform via S3 et DynamoDB.
- **01-network**: VPC complet avec subnets privés/publics et NAT gateway conditionnel.
- **02-security**: Architecture "3-Tiers" pour les Security Groups et rôles IAM de base.
- **GitOps CI/CD**: Workflow GitHub Actions matrixé pour valider et formater le code sur les PRs.

## Next Milestone Goals
(Run `@[/gsd-new-milestone]` to define next milestone)
