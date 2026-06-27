# Phase 3.0 Context: Security Layer - Sécurité (02-security)

## Decisions
- **D-01 | Isolation des Groupes de Sécurité (SG)**: Implémentation du modèle "3-Tiers" standard :
  - `alb_sg` (Public) : Ouvert sur internet (ports 80/443).
  - `app_sg` (Privé) : Ouvert uniquement au trafic provenant du `alb_sg`.
  - `db_sg` (Privé) : Ouvert uniquement au trafic provenant du `app_sg` sur le port 5432 (Postgres).
- **D-02 | Gestion des Accès (IAM)**: Création d'un rôle d'exécution EC2/ECS de base (`app_execution_role`) permettant à l'application de lire des paramètres chiffrés et d'écrire des logs (CloudWatch), sans donner de droits excessifs (Principe du moindre privilège).
- **D-03 | Dépendance Inter-Couches**: Utilisation de `terraform_remote_state` pour récupérer l'ID du VPC créé lors de la Phase 2.0 (`01-network`), garantissant que la sécurité est appliquée sur le bon réseau.
