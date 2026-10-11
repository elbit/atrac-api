#!/usr/bin/env bash
set -euo pipefail

# Arranca el servidor atrac-api en el puerto 5000 (en background).
# Se ejecuta en cada arranque del Codespace (postStartCommand).

cd "$(dirname "$0")/.."   # raíz del repo: aquí viven main.py y psp_at3tool.exe

export WINEPREFIX="$PWD/.wine"
export WINEARCH=win32
export WINEDEBUG=-all

# Evita procesos duplicados si el script se ejecuta dos veces
pkill -f "uvicorn main:api" 2>/dev/null || true

# Asegura que el prefijo Wine exista
wineboot -i >/dev/null 2>&1 || true

nohup uvicorn main:api --host 0.0.0.0 --port 5000 > "$HOME/atrac-api.log" 2>&1 &
sleep 2

echo "atrac-api escuchando en :5000 (log: ~/atrac-api.log)"
