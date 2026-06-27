# Project: Terraform Enterprise Platform Template

## Context
**What This Is:** Un template d'infrastructure AWS (Landing Zone) générique, réutilisable et prêt pour la production (multi-environnements).
**Why It Exists:** Créer un standard d'entreprise pour les futurs projets, démontrer une maîtrise complète du Cloud/Platform Engineering (AWS, Remote State, Isolation), et remplacer la gestion manuelle par une approche GitOps stricte.
**Core Value:** Déploiement standardisé, sécurisé et reproductible. Séparation forte entre les modules réutilisables (génériques) et les configurations spécifiques (Live).

## Requirements

### Validated

(None yet — ship to validate)

### Active

- [ ] Mise en place du Remote State Backend (AWS S3 + DynamoDB State Locking).
- [ ] Déploiement des fondations réseau (VPC, Subnets, Nat Gateway).
- [ ] Mise en place des fondations de sécurité (IAM Roles, Security Groups de base).
- [ ] Structure des dossiers isolant `dev`, `staging`, et `prod` avec `tfvars`.
- [ ] CI/CD minimal pour plan/apply automatique (GitHub Actions).

### Out of Scope

- [ ] Utilisation de Terragrunt (Choix d'apprentissage : Maîtrise de Terraform natif d'abord).
- [ ] Déploiement d'applications complexes (Couche 4 bloquée tant que 1 & 2 ne sont pas prêtes).

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| AWS Cloud Provider | Standard absolu de l'industrie pour les rôles Cloud/Platform Engineer. | — Pending |
| Terraform Natif | Solider les bases (Workspaces/tfvars) avant d'ajouter l'abstraction Terragrunt. | — Pending |
| S3 + DynamoDB Lock | Pattern standard et sécurisé pour le travail en équipe et le CI/CD. | — Pending |
| Modèle Générique | Permet d'instancier N projets clients à partir du même template de base. | — Pending |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):
1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):
1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-06-27 after initialization*
