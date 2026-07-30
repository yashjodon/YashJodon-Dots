#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
# logger.sh
#
# Logging Library
# ==========================================================

[[ "${YJD_LOGGER_LOADED:-0}" == "1" ]] && return 0
readonly YJD_LOGGER_LOADED=1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color library
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/colors.sh"

readonly LOG_DIR="${HOME}/.local/share/yashjodon-dots/logs"
readonly LOG_FILE="${LOG_DIR}/installer.log"

mkdir -p "${LOG_DIR}"

yjd_timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

yjd_log() {

    local level="$1"
    shift

    local message="$*"

    printf "[%s] [%s] %s\n" \
        "$(yjd_timestamp)" \
        "${level}" \
        "${message}" >> "${LOG_FILE}"
}

yjd_log_info() {

    local message="$*"

    yjd_print_color bright-blue "[INFO] "
    printf "%s\n" "${message}"

    yjd_log INFO "${message}"
}

yjd_log_success() {

    local message="$*"

    yjd_print_color bright-green "[ OK ] "
    printf "%s\n" "${message}"

    yjd_log SUCCESS "${message}"
}

yjd_log_warning() {

    local message="$*"

    yjd_print_color bright-yellow "[WARN] "
    printf "%s\n" "${message}"

    yjd_log WARNING "${message}"
}

yjd_log_error() {

    local message="$*"

    yjd_print_color bright-red "[FAIL] "
    printf "%s\n" "${message}"

    yjd_log ERROR "${message}"
}