#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
# system.sh
#
# System helper library
# ==========================================================

[[ "${YJD_SYSTEM_LOADED:-0}" == "1" ]] && return 0
readonly YJD_SYSTEM_LOADED=1

# ----------------------------------------------------------
# Command helpers
# ----------------------------------------------------------

yjd_command_exists() {
    command -v "$1" >/dev/null 2>&1
}

yjd_require_command() {

    local cmd="$1"

    if ! yjd_command_exists "${cmd}"; then
        yjd_log_error "Required command not found: ${cmd}"
        return 1
    fi

    return 0
}

# ----------------------------------------------------------
# User helpers
# ----------------------------------------------------------

yjd_is_root() {
    [[ "${EUID}" -eq 0 ]]
}

yjd_has_sudo() {
    command -v sudo >/dev/null 2>&1
}

# ----------------------------------------------------------
# Shell
# ----------------------------------------------------------

yjd_require_bash() {

    if [[ -z "${BASH_VERSION:-}" ]]; then
        printf "This project requires Bash.\n" >&2
        return 1
    fi

    return 0
}

yjd_detect_shell() {

    if [[ -n "${BASH_VERSION:-}" ]]; then
        printf "bash\n"
        return
    fi

    if [[ -n "${ZSH_VERSION:-}" ]]; then
        printf "zsh\n"
        return
    fi

    printf "unknown\n"
}

# ----------------------------------------------------------
# Network
# ----------------------------------------------------------

yjd_check_internet() {

    if command -v curl >/dev/null 2>&1; then
        curl \
            --silent \
            --fail \
            --head \
            --max-time 5 \
            https://github.com >/dev/null

        return $?
    fi

    if command -v wget >/dev/null 2>&1; then
        wget \
            --spider \
            --quiet \
            --timeout=5 \
            https://github.com

        return $?
    fi

    return 1
}