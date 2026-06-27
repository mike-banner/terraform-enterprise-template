# Phase 4.0 Context: GitOps CI/CD Integration

## Decisions
- **D-01 | GitHub Actions Workflow**: Le workflow CI/CD sera implémenté via GitHub Actions (`.github/workflows/terraform.yml`).
- **D-02 | Déclencheurs (Triggers)**: Le pipeline s'exécutera automatiquement sur les "Pull Requests" ciblant la branche `main`, ainsi que lors d'un "Push" sur `main`.
- **D-03 | Étapes de validation (CI)**: Chaque exécution devra valider le format du code (`terraform fmt -check`), son intégrité syntaxique (`terraform validate`), et enfin générer un plan (`terraform plan`) de manière asynchrone pour afficher les changements dans la Pull Request.
- **D-04 | Gestion des Secrets AWS**: L'authentification auprès d'AWS par la CI se fera idéalement via OIDC (OpenID Connect) ou via l'injection de secrets standard `AWS_ACCESS_KEY_ID` et `AWS_SECRET_ACCESS_KEY` depuis GitHub.
