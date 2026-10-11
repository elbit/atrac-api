#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# atrac-api devcontainer: instalación inicial.
# Se ejecuta UNA vez al crear el Codespace (postCreateCommand), como usuario
# "vscode" (tiene sudo sin contraseña en esta imagen).
#
# psp_at3tool.exe es un binario Windows de 32 bits (PE32) -> hace falta Wine
# con soporte i386, igual que hace el Dockerfile original del proyecto.
# ---------------------------------------------------------------------------

echo "[setup] Añadiendo arquitectura i386..."
sudo dpkg --add-architecture i386
sudo apt-get update

echo "[setup] Instalando ffmpeg + wine32..."
sudo apt-get install -y --no-install-recommends ffmpeg wine32 wine:i386
sudo apt-get clean

echo "[setup] Instalando dependencias Python..."
pip install --upgrade pip
pip install -r requirements.txt

echo "[setup] Creando prefijo Wine de 32 bits..."
export WINEPREFIX="$PWD/.wine"
export WINEARCH=win32
wineboot -i >/dev/null 2>&1 || true

echo "[setup] Listo."
