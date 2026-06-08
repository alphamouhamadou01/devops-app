# DevOps App - TP Automatisation UCAD 2025-2026

## Description
Application Node.js simple avec pipeline CI/CD automatise.
Accessible en ligne : https://devops-app-wlw5.onrender.com

## Prerequis
- Node.js
- npm
- Git

## Installation
```bash
npm install
```

## Lancer les tests
```bash
npm test
```

## Lancer l'application en local
```bash
npm start
```
Puis ouvrir : http://localhost:3000

## Routes disponibles
- GET / → retourne "pong"
- GET /health → retourne le statut de l'application

## Script de deploiement automatique
```bash
chmod +x auto_deploy.sh
./auto_deploy.sh <URL_DU_DEPOT>
```

## Pipeline CI/CD
Le pipeline GitHub Actions se declenche automatiquement a chaque push sur la branche main.
Il execute les etapes suivantes :
1. Installation des dependances
2. Execution des tests unitaires
3. Build de l'application
4. Deploiement sur Render.com si les tests passent

## Application deployee
URL de production : https://devops-app-wlw5.onrender.com
