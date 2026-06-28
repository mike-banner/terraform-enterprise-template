# Terraform Enterprise Platform Template

Ce dépôt est un **Template Générique et Réutilisable** pour déployer des infrastructures AWS de niveau production. Il est conçu pour servir de point de départ standardisé pour n'importe quel nouveau projet client ou produit interne.

## 🎯 Philosophie du Template

1. **Générique** : Ce dépôt ne contient aucune donnée "hardcodée" d'un client spécifique. Tout est paramétrable via des variables (`tfvars`).
2. **Standard AWS** : Utilisation exclusive des bonnes pratiques AWS (VPC isolé, IAM minimaliste, State Backend S3/DynamoDB).
3. **Modulaire** : Les ressources sont encapsulées dans des modules locaux réutilisables.
4. **GitOps** : Les environnements sont pilotés à 100% par du code, avec un CI/CD pour planifier et appliquer les changements.

## 🏗️ Architecture en Couches Logiques (Layers)

L'infrastructure est découpée en couches de dépendances strictes. Une couche supérieure ne peut que lire l'état d'une couche inférieure, jamais la modifier.

```text
.
├── .planning/                # Documentation IA (GSD)
├── terraform/                # Infrastructure as Code
│   ├── modules/              # Modules Terraform génériques
│   ├── 00-remote-state/      # FONDATIONS 0 : S3 & DynamoDB State
│   ├── 01-network/           # FONDATIONS 1 : AWS VPC, Subnets, NAT
│   ├── 02-security/          # SECURITÉ     : AWS IAM Roles, SG, KMS
│   ├── 03-data/              # DONNÉES      : RDS, DynamoDB, S3
│   └── 04-app-platform/      # APPLICATIONS : ECS/EKS, Load Balancers
```

## 🌍 Environnements Isolés

Dans chaque couche logique, on gère les environnements avec Terraform natif :
- `dev.tfvars` : Environnement de développement et de test (ressources minimales pour économiser les coûts).
- `staging.tfvars` : Pré-production (réplique fonctionnelle de la prod).
- `prod.tfvars` : Production réelle (Haute Disponibilité, Multi-AZ).

## 🔒 Gestion de l'État (Remote State)

Le State Terraform (`.tfstate`) n'est jamais stocké localement. Il utilise :
- **AWS S3** : Stockage chiffré des fichiers d'état.
- **AWS DynamoDB** : Mécanisme de "State Locking" pour empêcher deux exécutions simultanées d'écraser la production.

## 🚀 Comment utiliser ce Template pour un nouveau projet ?

1. Cloner ce dépôt (sans l'historique git ou comme un Template Repository GitHub).
2. Adapter les valeurs par défaut globales (nom du projet, région AWS).
3. Initialiser le Backend S3/DynamoDB.
4. Appliquer les couches séquentiellement (`01-network` puis `02-security`, etc.).
