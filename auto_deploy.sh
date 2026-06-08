#!/bin/bash

# ============================================
# Script d'automatisation du deploiement
# Auteur : TP DevOps UCAD 2025-2026
# ============================================

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fichier de log
LOG_FILE="deploy.log"

# ============================================
# Fonction de log avec horodatage
# ============================================
log() {
  local MESSAGE="$1"
  local TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  echo -e "${YELLOW}[$TIMESTAMP]${NC} $MESSAGE"
  echo "[$TIMESTAMP] $MESSAGE" >> "$LOG_FILE"
}

# ============================================
# Verification des dependances
# ============================================
log "=== Debut du deploiement automatique ==="

log "Verification des dependances..."

command -v git >/dev/null 2>&1 || { log "${RED}Git requis mais non installe. Abandon.${NC}"; exit 1; }
log "${GREEN}Git : OK${NC}"

command -v node >/dev/null 2>&1 || { log "${RED}Node.js requis mais non installe. Abandon.${NC}"; exit 1; }
log "${GREEN}Node.js : OK${NC}"

command -v npm >/dev/null 2>&1 || { log "${RED}npm requis mais non installe. Abandon.${NC}"; exit 1; }
log "${GREEN}npm : OK${NC}"

# ============================================
# Verification du parametre URL
# ============================================
if [ -z "$1" ]; then
  log "${RED}Erreur : URL du depot manquante.${NC}"
  echo -e "Usage : ${GREEN}./auto_deploy.sh <URL_DU_DEPOT>${NC}"
  exit 1
fi

REPO_URL="$1"
PROJECT_DIR="app_deployee"

log "URL du depot : $REPO_URL"

# ============================================
# Clonage ou mise a jour du depot
# ============================================
if [ -d "$PROJECT_DIR" ]; then
  log "Le repertoire $PROJECT_DIR existe deja. Mise a jour..."
  cd "$PROJECT_DIR" && git pull
  cd ..
else
  log "Clonage du repository..."
  git clone "$REPO_URL" "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"

# ============================================
# Installation des dependances
# ============================================
log "Installation des dependances npm..."
npm install

if [ $? -ne 0 ]; then
  log "${RED}Echec de l'installation des dependances. Abandon.${NC}"
  exit 1
fi
log "${GREEN}Dependances installees avec succes.${NC}"

# ============================================
# Lancement des tests
# ============================================
log "Lancement des tests unitaires..."
npm test

if [ $? -eq 0 ]; then
  log "${GREEN}Tous les tests sont passes avec succes.${NC}"
else
  log "${RED}Echec des tests. Deploiement interrompu.${NC}"
  exit 1
fi

# ============================================
# Demarrage de l'application en arriere-plan
# ============================================
log "Demarrage de l'application en arriere-plan..."
npm start &
APP_PID=$!

echo "$APP_PID" > ../app.pid
log "${GREEN}Application demarree avec succes. PID = $APP_PID${NC}"
log "Le PID a ete sauvegarde dans le fichier app.pid"
log "=== Deploiement termine avec succes ==="
