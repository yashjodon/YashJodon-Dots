#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

source "${PROJECT_ROOT}/scripts/utils/timer.sh"

echo
echo "===== TIMER TEST ====="
echo

yjd_timer_start

sleep 2

echo "Elapsed Seconds : $(yjd_timer_elapsed)"
echo "Pretty Format   : $(yjd_timer_pretty)"

echo
echo "PASS"