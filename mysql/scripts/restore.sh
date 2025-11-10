#!/usr/bin/env bash
set -euo pipefail
# Restore a dump into target database.
# Usage: ./scripts/restore.sh <dump.sql> [db_name]
DUMP="${1:-}"; [[ -f "$DUMP" ]] || { echo "Dump not found"; exit 1; }
DB_NAME="${2:-${DB_NAME:-app_db}}"
mysql -h "${DB_HOST:-localhost}" -P "${DB_PORT:-3306}" -u "${DB_USER:-app}" -p"${DB_PASSWORD:-app_password}" \
  "${DB_NAME}" < "${DUMP}"
echo "Restore completed into ${DB_NAME}"
