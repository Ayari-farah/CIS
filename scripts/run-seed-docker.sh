#!/usr/bin/env bash
# Run bulk_seed_test_data.py inside the ml-service container so it connects to
# hostname "mariadb" on port 3306. Use this when MariaDB is only reachable on
# the Docker network (or when localhost:3307 is not listening).
#
# Usage (from repo root, with MariaDB already running):
#   docker compose up -d mariadb
#   ./scripts/run-seed-docker.sh --dry-run
#   ./scripts/run-seed-docker.sh --total 3000 --users 10
#   ./scripts/run-seed-docker.sh --delete
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

docker compose run --rm \
  -v "$ROOT/scripts:/scripts:ro" \
  -e DB_HOST=mariadb \
  -e DB_PORT=3306 \
  -e DB_USER="${DB_USER:-civic_user}" \
  -e DB_PASSWORD="${DB_PASSWORD:-civic_password}" \
  -e DB_NAME="${DB_NAME:-civic_platform}" \
  ml-service \
  python /scripts/bulk_seed_test_data.py "$@"
