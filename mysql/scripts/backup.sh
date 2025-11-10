#!/usr/bin/env bash
set -euo pipefail
# Logical backup with sane defaults.
# Usage: ./scripts/backup.sh <db_name>
DB_NAME="${1:-${DB_NAME:-app_db}}"
STAMP="$(date +%F_%H%M%S)"
mkdir -p backups
mysqldump -h "${DB_HOST:-localhost}" -P "${DB_PORT:-3306}" -u "${DB_USER:-app}" -p"${DB_PASSWORD:-app_password}" \
  --single-transaction --quick --routines --triggers --events \
  "${DB_NAME}" > "backups/${DB_NAME}_${STAMP}.sql"
echo "Backup written to backups/${DB_NAME}_${STAMP}.sql"
