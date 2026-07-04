#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

source "${PROJECT_ROOT}/scripts/utils/colors.sh"
source "${PROJECT_ROOT}/scripts/utils/logger.sh"
source "${PROJECT_ROOT}/scripts/utils/system.sh"

tests=0
passed=0

run_test() {

    local name="$1"
    shift

    tests=$((tests + 1))

    if "$@"; then
        printf "✔ %s\n" "${name}"
        passed=$((passed + 1))
    else
        printf "✘ %s\n" "${name}"
    fi
}

test_command() {
    yjd_command_exists bash
}

test_require() {
    yjd_require_command bash
}

test_shell() {
    [[ "$(yjd_detect_shell)" == "bash" ]]
}

test_bash() {
    yjd_require_bash
}

run_test "command_exists" test_command
run_test "require_command" test_require
run_test "detect_shell" test_shell
run_test "require_bash" test_bash

printf "\nPassed %d/%d tests\n" "${passed}" "${tests}"

[[ "${passed}" -eq "${tests}" ]]