#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
# distro.sh
#
# Distribution Detection Module
# ==========================================================

[[ "${YJD_DISTRO_LOADED:-0}" == "1" ]] && return 0
readonly YJD_DISTRO_LOADED=1

# ----------------------------------------------------------
# Private Helpers
# ----------------------------------------------------------

_yjd_load_os_release() {

    [[ -r /etc/os-release ]] || return 1

    # shellcheck disable=SC1091
    source /etc/os-release
}

_yjd_command_exists() {

    command -v "$1" >/dev/null 2>&1

}

# ----------------------------------------------------------
# Distribution
# ----------------------------------------------------------

yjd_detect_distro() {

    _yjd_load_os_release || {
        printf "unknown"
        return 1
    }

    printf "%s" "${ID:-unknown}"
}

yjd_distro_name() {

    _yjd_load_os_release || {
        printf "Unknown Linux"
        return 1
    }

    printf "%s" "${PRETTY_NAME:-${NAME:-Unknown Linux}}"
}

yjd_distro_version() {

    _yjd_load_os_release || {
        printf "Unknown"
        return 1
    }

    printf "%s" "${VERSION_ID:-Unknown}"
}

# ----------------------------------------------------------
# System
# ----------------------------------------------------------

yjd_kernel_version() {

    uname -r

}

yjd_architecture() {

    uname -m

}

# ----------------------------------------------------------
# Package Manager
# ----------------------------------------------------------

yjd_package_manager() {

    if _yjd_command_exists paru; then
        printf "paru"
        return 0
    fi

    if _yjd_command_exists yay; then
        printf "yay"
        return 0
    fi

    if _yjd_command_exists pacman; then
        printf "pacman"
        return 0
    fi

    printf "unknown"

    return 1
}

# ----------------------------------------------------------
# Supported Distribution
# ----------------------------------------------------------

yjd_is_supported() {

    case "$(yjd_detect_distro)" in

        arch|cachyos|endeavouros|manjaro|garuda)

            return 0
            ;;

        *)

            return 1
            ;;

    esac
}

# ----------------------------------------------------------
# Print Information
# ----------------------------------------------------------

yjd_print_system_info() {

    printf "\n"

    printf "Distribution : %s\n" "$(yjd_distro_name)"

    printf "Version      : %s\n" "$(yjd_distro_version)"

    printf "Kernel       : %s\n" "$(yjd_kernel_version)"

    printf "Architecture : %s\n" "$(yjd_architecture)"

    printf "Package Mgr  : %s\n" "$(yjd_package_manager)"

    if yjd_is_supported; then
        printf "Status       : Supported\n"
    else
        printf "Status       : Unsupported\n"
    fi

    printf "\n"
}
