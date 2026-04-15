#!/usr/bin/env bash
# Stops the stack and removes named volumes (MariaDB + ML model files).
# Plain `docker compose down` keeps volumes — your DB and seed data persist.
#
# Usage (from repo root):
#   ./scripts/compose-down-clean.sh
#   ./scripts/compose-down-clean.sh --remove-orphans
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
exec docker compose down -v "$@"
