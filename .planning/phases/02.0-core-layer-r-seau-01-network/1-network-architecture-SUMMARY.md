# Plan 1 Summary: Architecture Réseau (VPC)

## What was done
- Création de la couche réseau dans `terraform/01-network/`.
- Définition du provider AWS avec un backend `s3` générique (attendant sa configuration à l'initialisation).
- Utilisation du module officiel `terraform-aws-modules/vpc/aws` pour instancier le réseau avec les bonnes pratiques.
- Configuration du réseau pour s'étendre automatiquement sur les 2 premières AZs de la région (`slice(data.aws_availability_zones.available.names, 0, 2)`).
- Génération automatique des sous-réseaux (Publics et Privés) grâce à la fonction `cidrsubnet`.
- Création des 3 fichiers d'environnements :
  - `dev.tfvars` (NAT Gateway: false, CIDR: 10.0.0.0/16)
  - `staging.tfvars` (NAT Gateway: false, CIDR: 10.1.0.0/16)
  - `prod.tfvars` (NAT Gateway: true, CIDR: 10.2.0.0/16)
- Exportation des identifiants cruciaux (VPC ID, Subnets IDs) via `outputs.tf` pour les phases suivantes.

## Notes & Decisions
- L'utilisation du module officiel d'AWS garantit que la table de routage, les Internet Gateways et les subnets sont configurés selon les meilleurs standards de sécurité.
- L'absence de NAT Gateway en dev/staging signifie que les ressources privées n'auront pas d'accès Internet sortant dans ces environnements, générant une économie significative (~64$/mois).
