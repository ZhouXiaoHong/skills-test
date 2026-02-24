#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${1:-.}"
PATTERN_FILE="$(dirname "$0")/../patterns/keys.txt"

echo "Scanning: ${ROOT_DIR}"
rg -n -f "${PATTERN_FILE}" "${ROOT_DIR}" || true
