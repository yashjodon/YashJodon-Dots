#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

source "${PROJECT_ROOT}/scripts/utils/logger.sh"

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

test_info() {

    yjd_log_info "Info Test"

}

test_success() {

    yjd_log_success "Success Test"

}

test_warning() {

    yjd_log_warning "Warning Test"

}

test_error() {

    yjd_log_error "Error Test"

}

test_log_file() {

    [[ -f "${LOG_FILE}" ]]

}

echo
echo "========== Logger Tests =========="
echo

run_test "Info" test_info
run_test "Success" test_success
run_test "Warning" test_warning
run_test "Error" test_error
run_test "Log File" test_log_file

echo
printf "Passed %d/%d tests\n" "${passed}" "${tests}"

[[ "${passed}" -eq "${tests}" ]]