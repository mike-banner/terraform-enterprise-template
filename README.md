# 🏗️ Terraform Enterprise Platform Template

Ce dépôt est un **Template Générique et Réutilisable** pour déployer des infrastructures Cloud de niveau production. Il est conçu pour servir de point de départ standardisé pour n'importe quel nouveau projet client ou produit interne.

---

## 🎯 Philosophie du Template

1. **Générique** : Ce dépôt ne contient aucune donnée "hardcodée" d'un client spécifique. Tout est paramétrable via des variables (`tfvars`).
2. **Standard AWS** : Utilisation exclusive des bonnes pratiques AWS (VPC isolé, IAM minimaliste, State Backend S3/DynamoDB).
3. **Modulaire** : Les ressources sont encapsulées dans des modules locaux réutilisables.
4. **GitOps** : Les environnements sont pilotés à 100% par du code, avec un CI/CD pour vérifier et planifier les changements automatiquement.

---

## 🏗️ Architecture en Couches Logiques (Layers)

L'infrastructure est découpée en couches de dépendances strictes. Une couche supérieure ne peut que lire l'état d'une couche inférieure, jamais la modifier.

```text
.
├── .github/                  # Workflows GitOps CI/CD
├── .planning/                # Documentation et Planification (GSD)
├── terraform/                # Infrastructure as Code
│   ├── modules/              # Modules Terraform génériques
│   ├── 00-remote-state/      # FONDATIONS 0 : S3 & DynamoDB State
│   ├── 01-network/           # FONDATIONS 1 : AWS VPC, Subnets, NAT
│   ├── 02-security/          # SECURITÉ     : AWS IAM Roles, SG, KMS
│   ├── 03-data/              # DONNÉES      : RDS, DynamoDB, S3
│   └── 04-app-platform/      # APPLICATIONS : ECS/EKS, Load Balancers
```

---

## 🌍 Environnements Isolés

Dans chaque couche logique, on gère les environnements avec Terraform natif :
- `dev.tfvars` : Environnement de développement et de test (ressources minimales, pas de NAT Gateway pour économiser les coûts).
- `staging.tfvars` : Pré-production (réplique fonctionnelle de la prod).
- `prod.tfvars` : Production réelle (Haute Disponibilité, NAT Gateway activée).

---

## 🔒 Gestion de l'État (Remote State)

Le State Terraform (`.tfstate`) n'est jamais stocké localement. Il utilise :
- **AWS S3** : Stockage chiffré des fichiers d'état.
- **AWS DynamoDB** : Mécanisme de "State Locking" pour empêcher deux exécutions simultanées d'écraser la production.

---

## 🚀 Évolutions et Nouvelles Épopées (Milestones)

L'avantage de ce template est son évolution assistée par IA (Antigravity/GSD). 

Si tu souhaites lancer une **nouvelle grande épopée** pour faire évoluer cette architecture (par exemple : *Ajouter un cluster ECS Kubernetes*, *Adapter l'infrastructure entière pour Hetzner*, ou *Déployer Supabase as Code*), il te suffit d'utiliser la commande d'initialisation de jalon :

```bash
@[/gsd-new-milestone]
```

L'assistant t'accompagnera pour définir tes nouvelles "Requirements", et planifier la nouvelle roadmap !

---

> 👨‍💻 **Fait par Michael Banicles**
