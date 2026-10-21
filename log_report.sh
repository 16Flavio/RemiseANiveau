#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Erreur : Aucun fichier de log fourni." >&2
    echo "Usage : $0 <fichier_de_logs>" >&2
    exit 1
fi

LOG_FILE="$1"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Erreur : Le fichier '$LOG_FILE' n'existe pas ou n'est pas un fichier standard." >&2
    exit 1
fi

OUTPUT_DIR="processed"
mkdir -p "$OUTPUT_DIR"
DATE_STR=$(date +"%Y-%m-%d")
REPORT_FILE="${OUTPUT_DIR}/report_${DATE_STR}.txt"

{
    echo "=========================================="
    echo "   RAPPORT D'ANALYSE DE LOGS SUPER COOL   "
    echo "=========================================="
    echo "Fichier analysé : $LOG_FILE"
    echo "Date du rapport : $(date +"%Y-%m-%d %H:%M:%S")"
    echo "------------------------------------------"

    TOTAL_LINES=$(wc -l < "$LOG_FILE")
    echo "Nombre total d'entrées : $TOTAL_LINES"
    echo ""

   echo "--- Répartition par niveau ---"
   awk '{print $2}' "$LOG_FILE" | sort | uniq -c | sort -k1,1nr -k2,2 \
   	| awk '{printf "  %-10s : %d\n", $2, $1}'

    echo "--- Top 3 des IP en erreur ---"
    awk '$2 == "ERROR" {print $3}' "$LOG_FILE" | sort | uniq -c \
    	| sort -k1,1nr -k2,2 | head -n 3 \
    	| awk '{printf "  %-15s : %d\n", $2, $1}'
    echo ""

    echo "--- Jour le plus chargé ---"
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -k1,1nr -k2,2 | head -n 1 \
    	| awk '{printf "  %s (%d entrées)\n", $2, $1}'

    echo "=========================================="
} | tee "$REPORT_FILE"

echo "Rapport enregistré dans : $REPORT_FILE"
