#!/bin/bash
# ============================================================
# autocommit.sh — Registro automático de avance (Audit Log)
# Ejecuta git commit cada 5 minutos si hay cambios pendientes
# ============================================================

SLEEP_SECONDS=300
REPO_PATH="${1:-/workspaces/test-validation-partial-01}"

cd "$REPO_PATH" || {
  echo "[autocommit] ERROR: No se pudo acceder a $REPO_PATH"
  exit 1
}

echo "[autocommit] Iniciando monitoreo de cambios cada ${SLEEP_SECONDS}s en $REPO_PATH"

while true; do
  sleep "$SLEEP_SECONDS"

  if [ ! -d .git ]; then
    echo "[autocommit] No es un repositorio git, omitiendo..."
    continue
  fi

  git add -A 2>/dev/null

  if git diff --cached --quiet 2>/dev/null; then
    echo "[autocommit] $(date '+%H:%M:%S') — Sin cambios"
  else
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "Auto-commit: avance registrado — $TIMESTAMP" 2>/dev/null
    echo "[autocommit] $(date '+%H:%M:%S') — Commit realizado: avance registrado"
  fi
done
