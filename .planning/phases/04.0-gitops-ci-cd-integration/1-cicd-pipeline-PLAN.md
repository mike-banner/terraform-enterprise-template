---
wave: 1
depends_on: []
files_modified: [
  ".github/workflows/terraform.yml"
]
autonomous: true
---

# Plan 1: GitOps CI/CD Integration

## Objective
Automatiser la vérification et le déploiement de l'infrastructure via GitHub Actions pour instaurer un véritable workflow GitOps.

## Context
L'objectif ultime de cette architecture est que chaque développeur (ou toi-même) puisse proposer une modification d'infrastructure via une Pull Request (PR). GitHub Actions doit prendre le relais pour s'assurer que le code est propre (`fmt`), valide (`validate`) et qu'il produira le résultat escompté (`plan`). Ce pipeline est la clé de voûte de "l'Infrastructure as Code".

## Tasks

### 1. Créer le répertoire workflow
<action>
Créer le dossier `.github/workflows/` à la racine du projet.
</action>
<acceptance_criteria>
- Le dossier `.github/workflows/` existe.
</acceptance_criteria>

### 2. Écrire le workflow GitHub Actions
<action>
Créer le fichier `.github/workflows/terraform.yml`.
Y définir un job qui se déclenche sur `push` vers `main` et sur `pull_request`.
Le job doit tourner sur `ubuntu-latest`.
Intégrer les étapes suivantes dans le job :
1. `actions/checkout@v3`
2. `hashicorp/setup-terraform@v2`
3. Exécution de `terraform init`
4. Exécution de `terraform fmt -check`
5. Exécution de `terraform validate -no-color`
6. (Optionnel pour le moment) Exécution de `terraform plan -no-color` uniquement sur les Pull Requests.
Pour que `init` et `plan` fonctionnent sur GitHub, ajouter des placeholders (ou commentaires) pour l'authentification AWS (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).
</action>
<acceptance_criteria>
- Le fichier `terraform.yml` contient toutes les étapes nécessaires à l'analyse syntaxique et à la planification.
- La syntaxe YAML est valide.
</acceptance_criteria>

## Verification
- Vérifier la structure du fichier YAML généré.

## Must Haves
- truths:
  - "D-01: GitHub Actions yaml creation"
  - "D-02: Triggers on PR and push to main"
  - "D-03: fmt, validate, plan steps included"
