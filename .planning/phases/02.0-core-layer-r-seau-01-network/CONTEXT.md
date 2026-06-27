# Phase 2.0 Context: Core Layer - Réseau (01-network)

## Decisions
- **D-01 | Séparation Réseau | Public & Privé**: Le réseau (VPC) sera divisé strictement en deux. Une zone Publique pour les ressources devant être accessibles depuis Internet, et une zone Privée totalement isolée pour les bases de données et les serveurs critiques.
- **D-02 | Coûts & Sortie Internet | NAT Gateway Économique**: Afin de ne pas générer de frais inutiles (32$/mois), la NAT Gateway (qui permet aux serveurs privés de sortir sur internet) sera désactivée par défaut dans les environnements de test (`dev`, `staging`). Elle ne sera activée que via les variables de `prod`.
- **D-03 | Haute Disponibilité | 2 Zones de Disponibilité (AZ)**: Le réseau sera étalé sur 2 Data-Centers physiques d'AWS (Multi-AZ) dès sa création. C'est gratuit et cela prépare le terrain pour des architectures redondantes à l'avenir.
