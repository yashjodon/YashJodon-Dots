#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

source "${PROJECT_ROOT}/scripts/utils/colors.sh"
source "${PROJECT_ROOT}/scripts/utils/ui.sh"

echo
echo "===== UI TEST ====="
echo

yjd_header

yjd_section "Testing Section"

echo "If the header and section are visible, UI works."

echo

echo "PASS"