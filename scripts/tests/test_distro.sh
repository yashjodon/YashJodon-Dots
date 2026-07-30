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

# shellcheck source=../modules/distro.sh
source "${PROJECT_ROOT}/scripts/modules/distro.sh"

echo
echo "========================================"
echo " Running Distro Module Tests"
echo "========================================"
echo

printf "Detected ID      : %s\n" "$(yjd_detect_distro)"
printf "Distribution     : %s\n" "$(yjd_distro_name)"
printf "Version          : %s\n" "$(yjd_distro_version)"
printf "Kernel           : %s\n" "$(yjd_kernel_version)"
printf "Architecture     : %s\n" "$(yjd_architecture)"
printf "Package Manager  : %s\n" "$(yjd_package_manager)"

if yjd_is_supported; then
    printf "Support Status   : Supported\n"
else
    printf "Support Status   : Unsupported\n"
fi

echo
echo "----- Full Output -----"

yjd_print_system_info

echo
echo "PASS"

