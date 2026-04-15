#!/usr/bin/env bash
# Free port 8082 (local default; Docker often uses 8081 on the host) then start the API.
set -euo pipefail
cd "$(dirname "$0")"
if command -v fuser >/dev/null 2>&1; then
  fuser -k 8082/tcp 2>/dev/null || true
  sleep 0.5
fi
exec env SERVER_PORT="${SERVER_PORT:-8082}" mvn spring-boot:run "$@"
