# Plan 1 Summary: GitOps CI/CD Integration

## What was done
- Création du répertoire `.github/workflows/`.
- Ajout du fichier `.github/workflows/terraform.yml.example`. Ce fichier a été nommé avec l'extension `.example` pour éviter qu'il ne s'exécute automatiquement (et n'échoue) sur un dépôt servant de template.
- Configuration du pipeline pour se déclencher sur les `push` et `pull_request` ciblant la branche `main`.
- Implémentation d'une matrice d'exécution (`strategy: matrix`) pour vérifier automatiquement les 3 couches d'infrastructure (`00-remote-state`, `01-network`, `02-security`) sur les 3 environnements (`dev`, `staging`, `prod`).
- Ajout des étapes clés de l'automatisation Terraform :
  - `terraform fmt -check` : pour s'assurer que le code est proprement formaté.
  - `terraform init` & `terraform validate` : pour vérifier la syntaxe.
  - `terraform plan` : pour simuler les changements.
- Ajout d'une étape finale qui publie automatiquement le résultat du `terraform plan` en commentaire directement dans la Pull Request GitHub, facilitant énormément la revue de code pour le reste de l'équipe.

## Notes & Decisions
- Le pipeline a été conçu pour être générique et "Enterprise-ready". Lors de l'utilisation réelle de ce template, le développeur n'aura qu'à renommer le fichier en `terraform.yml` et configurer ses secrets AWS dans les paramètres du dépôt GitHub pour que la magie opère.
