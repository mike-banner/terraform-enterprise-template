# Plan 1 Summary: Architecture de Sécurité (IAM & Security Groups)

## What was done
- Création de la couche `terraform/02-security/`.
- Configuration du provider AWS et de `terraform_remote_state` pour aller lire l'ID du VPC généré lors de la phase réseau (`01-network`).
- Implémentation du pattern "3-Tiers" avec 3 Security Groups :
  - `alb_sg` : Accepte le trafic web public (80/443).
  - `app_sg` : N'accepte que le trafic provenant de `alb_sg`.
  - `db_sg` : N'accepte que le trafic provenant de `app_sg` sur le port dynamique `var.db_port`.
- Ajout de la variable `db_port` (par défaut 5432) dans `variables.tf` et les fichiers `.tfvars`, permettant de changer le port de base de données à volonté sans modifier le module principal.
- Création du rôle IAM `app_execution_role` avec les droits de base (CloudWatch Logs) pour permettre aux conteneurs/serveurs applicatifs de tourner.
- Exportation des identifiants cruciaux (IDs des Security Groups et ARN du rôle IAM) via `outputs.tf` pour les phases d'application.

## Notes & Decisions
- Le port de base de données a été rendu dynamique suite à notre discussion, offrant plus de flexibilité si l'on souhaite dévier du port standard 5432 par "sécurité par l'obscurité", bien que le Security Group empêche déjà toute connexion non autorisée depuis l'extérieur.
- Le rôle IAM est très basique (uniquement CloudWatch) pour respecter la règle du moindre privilège.
