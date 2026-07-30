#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo
echo "========================================"
echo " YashJodon-Dots Test Suite"
echo "========================================"
echo

bash "${SCRIPT_DIR}/test_colors.sh"
bash "${SCRIPT_DIR}/test_logger.sh"
bash "${SCRIPT_DIR}/test_utils.sh"
bash "${SCRIPT_DIR}/test_system.sh"
bash "${SCRIPT_DIR}/test_files.sh"
bash "${SCRIPT_DIR}/test_ui.sh"
bash "${SCRIPT_DIR}/test_timer.sh"
bash "${SCRIPT_DIR}/test_installer.sh"
bash "${SCRIPT_DIR}/test_distro.sh"
bash "${SCRIPT_DIR}/test_packages.sh"

echo
echo "========================================"
echo " Finished"
echo "========================================"