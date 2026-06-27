# Plan 1 Summary: AWS Remote State Foundation

## What was done
Création de la couche d'infrastructure `00-remote-state` pour gérer le backend Terraform global.
- Création du `providers.tf` configuré pour AWS.
- Création du `variables.tf` avec `aws_region` et `project_prefix`.
- Création du `main.tf` instanciant :
  - Un bucket S3 (`aws_s3_bucket`) avec versioning, chiffrement AES256, et blocage des accès publics.
  - Une table DynamoDB (`aws_dynamodb_table`) pour le verrouillage (LockID).
- Création du `outputs.tf` exposant les noms des ressources.

## Notes & Decisions
- Le state de cette couche est local, car elle crée le bucket S3 qui sera utilisé par les autres couches. C'est le fonctionnement standard d'un environnement Terraform partagé.
- Un préfixe dynamique (`project_prefix`) permet de nommer le bucket S3 et la table de manière unique (ex: `tf-ent-plat-terraform-state`).
