#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
# Color Library Tests
# ==========================================================

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

source "${PROJECT_ROOT}/scripts/utils/colors.sh"

echo
echo "======================================"
echo " Running Color Tests"
echo "======================================"
echo

tests=0
passed=0

run_test() {

    local name="$1"
    shift

    tests=$((tests + 1))

    if "$@"; then

        printf "✔ %s\n" "$name"

        passed=$((passed + 1))

    else

        printf "✘ %s\n" "$name"

    fi
}

test_function_exists() {

    declare -F yjd_color >/dev/null

}

test_print_exists() {

    declare -F yjd_print_color >/dev/null

}

test_red() {

    yjd_print_color red "RED TEST"

    echo

}

test_green() {

    yjd_print_color green "GREEN TEST"

    echo

}

test_blue() {

    yjd_print_color blue "BLUE TEST"

    echo

}

run_test "Function yjd_color" test_function_exists
run_test "Function yjd_print_color" test_print_exists
run_test "Print Red" test_red
run_test "Print Green" test_green
run_test "Print Blue" test_blue

echo
echo "======================================"

printf "Passed %d/%d tests\n" "$passed" "$tests"

echo "======================================"

[[ "$passed" -eq "$tests" ]]