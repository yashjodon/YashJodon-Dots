#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

source "${PROJECT_ROOT}/scripts/utils/files.sh"

TMP_DIR="$(mktemp -d)"

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

test_directory() {

    yjd_safe_mkdir "${TMP_DIR}/demo"

    yjd_dir_exists "${TMP_DIR}/demo"
}

test_file() {

    touch "${TMP_DIR}/demo.txt"

    yjd_file_exists "${TMP_DIR}/demo.txt"
}

test_backup() {

    touch "${TMP_DIR}/backup.txt"

    yjd_backup_file "${TMP_DIR}/backup.txt"

    yjd_file_exists "${TMP_DIR}/backup.txt.bak"
}

test_copy() {

    touch "${TMP_DIR}/copy.txt"

    yjd_safe_copy "${TMP_DIR}/copy.txt" "${TMP_DIR}/copy2.txt"

    yjd_file_exists "${TMP_DIR}/copy2.txt"
}

test_move() {

    touch "${TMP_DIR}/move.txt"

    yjd_safe_move "${TMP_DIR}/move.txt" "${TMP_DIR}/moved.txt"

    yjd_file_exists "${TMP_DIR}/moved.txt"
}

test_symlink() {

    touch "${TMP_DIR}/link-source"

    yjd_create_symlink \
        "${TMP_DIR}/link-source" \
        "${TMP_DIR}/link-target"

    [[ -L "${TMP_DIR}/link-target" ]]
}

run_test "Create Directory" test_directory
run_test "File Exists" test_file
run_test "Backup File" test_backup
run_test "Copy File" test_copy
run_test "Move File" test_move
run_test "Create Symlink" test_symlink

rm -rf "${TMP_DIR}"

echo
printf "Passed %d/%d tests\n" "$passed" "$tests"

[[ "$passed" -eq "$tests" ]]