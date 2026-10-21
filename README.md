# Remise à niveau pour "Data Engineer"

Le but de ce répertoire est de me permettre de me remettre à niveau sur plein de compétences pour un ingénieur des données.
Tout sera fait sans IA générative.

# Premier script : log_report.sh

Script bash qui prend un fichier log en entrée et génère un rapport dans le dossier ./processed au format .txt.

Exemple d'utilisation :
```bash
./log_report.sh ./raw/app.log # Le dossier raw ne se trouve pas dans ce répertoire
```
Exemple de sortie :

```bash
==========================================
         RAPPORT D'ANALYSE DE LOGS        
==========================================
Fichier analysé : ./raw/app.log
Date du rapport : 2026-10-21 23:57:03
------------------------------------------
Nombre total d'entrées : 1000

--- Répartition par niveau ---
  INFO       : 599
  ERROR      : 209
  WARN       : 192

--- Top 3 des IP en erreur (ERROR/CRITICAL/FATAL) ---
  192.168.1.14    : 18 erreur(s)
  192.168.1.5     : 14 erreur(s)
  192.168.1.2     : 14 erreur(s)

--- Jour le plus chargé ---
  2026-10-26 (43 entrées)
==========================================
```
