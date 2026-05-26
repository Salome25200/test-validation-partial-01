#!/bin/bash
# ============================================================
# post-create.sh — Configuración posterior a la creación del contenedor
# 1. Bloquea dominios de Copilot y asistentes de IA en /etc/hosts
# 2. Configura Git para auditoría detallada
# 3. Inicia el script de auto-commit en segundo plano
# ============================================================

set -e

WORKSPACE_FOLDER="${1:-/workspaces/$(basename $(pwd))}"

echo "=== Configurando entorno de examen ==="

# --- Paso 1: Bloqueo de dominios de asistentes de IA en /etc/hosts ---
echo "[Paso 1] Bloqueando dominios de asistentes de IA..."

HOSTS_BLOCK=(
    "githubcopilot.com"
    "api.githubcopilot.com"
    "copilot.github.com"
    "copilot.microsoft.com"
    "api.tabnine.com"
    "www.tabnine.com"
)

for DOMAIN in "${HOSTS_BLOCK[@]}"; do
    if ! grep -q "127.0.0.1 $DOMAIN" /etc/hosts 2>/dev/null; then
        echo "127.0.0.1 $DOMAIN" | sudo tee -a /etc/hosts > /dev/null
        echo "  Bloqueado: $DOMAIN → 127.0.0.1"
    else
        echo "  Ya bloqueado: $DOMAIN"
    fi
done

# --- Paso 2: Configuración de Git para auditoría ---
echo "[Paso 2] Configurando Git para registro de auditoría..."

git config --global core.autocrlf input
git config --global commit.gpgsign false
git config --global log.showSignature false

echo "  Git configurado para auditoría detallada."

# --- Paso 3: Iniciar autocommit en segundo plano ---
echo "[Paso 3] Iniciando script de auto-commit..."

AUTOCOMMIT_SCRIPT="${WORKSPACE_FOLDER}/.devcontainer/autocommit.sh"
if [ -f "$AUTOCOMMIT_SCRIPT" ]; then
    chmod +x "$AUTOCOMMIT_SCRIPT"
    nohup bash "$AUTOCOMMIT_SCRIPT" "$WORKSPACE_FOLDER" > /tmp/autocommit.log 2>&1 &
    echo "  Auto-commit iniciado en segundo plano (PID $!)"
    echo "  Log disponible en: /tmp/autocommit.log"
else
    echo "  ADVERTENCIA: No se encontró $AUTOCOMMIT_SCRIPT"
fi

echo "=== Configuración del entorno completada ==="
