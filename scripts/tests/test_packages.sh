#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &&
    pwd
)"

PROJECT_ROOT="$(
    cd -- "${SCRIPT_DIR}/../.." &&
    pwd
)"

source "${PROJECT_ROOT}/scripts/modules/packages.sh"

echo
echo "======================================"
echo " Running Package Tests"
echo "======================================"
echo

echo "Package Manager : $(yjd_package_manager)"

echo

echo "Git Installed?"

if yjd_package_installed git; then

    echo "PASS"

else

    echo "FAIL"

fi