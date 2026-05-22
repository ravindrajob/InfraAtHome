################################################################
# Titre: Lilygo T5 4.7" Documentation
# Description : Guide de déploiement d'un dashboard E-Paper ultra basse consommation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################

# Dashboard E-Paper : Lilygo T5 4.7"

💡 **Philosophie : Low-Power Monitoring**
L'objectif de ce module est de fournir un affichage permanent des métriques critiques du Lab (consommation, température, état des services) en utilisant la technologie E-Paper (EPD). Contrairement aux écrans classiques, l'E-Paper ne consomme de l'énergie que lors du rafraîchissement de l'image.

## Spécifications Matérielles
- **Contrôleur :** ESP32-WROVER (8Mo PSRAM)
- **Écran :** 4.7" E-Paper (960x540 pixels)
- **Gestion Batterie :** Connecteur JST pour LiPo 3.7V intégré.

## Déploiement via ESPHome
L'infrastructure utilise **ESPHome** pour piloter l'écran. 
1.  Placer le fichier `lilygo-t5-dashboard.yaml` dans votre répertoire de config ESPHome.
2.  Ajouter vos polices TTF dans le dossier `fonts/`.
3.  Compiler et flasher l'ESP32.

## Optimisation SRE
Pour un usage en production (Lab de simulation), nous recommandons :
- **Deep Sleep :** Utiliser la fonction `deep_sleep` d'ESPHome pour ne réveiller l'ESP que toutes les 30 minutes.
- **Grayscale :** La Lilygo T5 4.7" supporte 16 niveaux de gris, idéal pour des graphiques de consommation élégants.

---
*Architecture conçue pour une durabilité maximale par Ravindra JOB.*
