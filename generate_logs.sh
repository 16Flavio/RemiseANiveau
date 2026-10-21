#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Erreur : Vous devez spécifier le nombre de lignes à générer." >&2
  echo "Usage : $0 <nombre_de_lignes>" >&2
  exit 1
fi

NB_LINES="$1"

if ! [[ "$NB_LINES" =~ ^[0-9]+$ ]]; then
  echo "Erreur : '$NB_LINES' n'est pas un nombre valide." >&2
  exit 1
fi

mkdir -p ~/de-lab/{raw,processed,logs}
for i in $(seq 1 "$NB_LINES"); do
  lvl=$(shuf -n1 -e INFO INFO INFO WARN ERROR)
  echo "2026-10-$(printf '%02d' $((RANDOM%28+1))) $lvl 192.168.1.$((RANDOM%20)) req_$i"
done > ~/de-lab/raw/app.log
