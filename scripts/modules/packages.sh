#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
# packages.sh
#
# Package Management Module
# ==========================================================

[[ "${YJD_PACKAGES_LOADED:-0}" == "1" ]] && return 0
readonly YJD_PACKAGES_LOADED=1

# ----------------------------------------------------------
# Counters
# ----------------------------------------------------------

YJD_PACKAGE_SUCCESS=0
YJD_PACKAGE_FAILED=0
YJD_PACKAGE_SKIPPED=0

# ----------------------------------------------------------
# Private Functions
# ----------------------------------------------------------

_yjd_execute_install() {

    local package
    package="$1"

    local manager
    manager="$(yjd_package_manager)"

    case "$manager" in

        paru)

            paru --needed --noconfirm -S "$package"
            ;;

        yay)

            yay --needed --noconfirm -S "$package"
            ;;

        pacman)

            sudo pacman --needed --noconfirm -S "$package"
            ;;

        *)

            yjd_log_error "Unsupported package manager: ${manager}"

            return 1
            ;;

    esac
}



_yjd_validate_package_name() {

    local package
    package="$1"

    [[ -n "$package" ]]

}

# ----------------------------------------------------------
# Public Functions
# ----------------------------------------------------------

yjd_package_manager() {

    if command -v paru >/dev/null 2>&1; then
        printf "paru"
        return 0
    fi

    if command -v yay >/dev/null 2>&1; then
        printf "yay"
        return 0
    fi

    printf "pacman"

}

yjd_package_installed() {

    pacman -Qi "$1" >/dev/null 2>&1

}

yjd_install_package() {

    local package
    package="$1"

    # Validate package name
    if ! _yjd_validate_package_name "$package"; then

        yjd_log_error "Invalid package name."

        ((YJD_PACKAGE_FAILED++))

        return 1

    fi

    # Already installed?
    if yjd_package_installed "$package"; then

        yjd_log_info "$package already installed."

        ((YJD_PACKAGE_SKIPPED++))

        return 0

    fi

    yjd_log_info "Installing ${package}..."

    if _yjd_execute_install "$package"; then

        yjd_log_success "$package installed."

        ((YJD_PACKAGE_SUCCESS++))

        return 0

    fi

    yjd_log_error "Failed to install ${package}"

    ((YJD_PACKAGE_FAILED++))

    return 1



}

yjd_install_package_file() {

    local file
    file="$1"

    if [[ ! -f "$file" ]]; then

        yjd_log_error "Package list not found: ${file}"

        return 1

    fi

    local package

    while IFS= read -r package || [[ -n "$package" ]]; do

        # Skip blank lines
        [[ -z "$package" ]] && continue

        # Skip comments
        [[ "${package}" =~ ^[[:space:]]*# ]] && continue

        yjd_install_package "$package"

    done < "$file"



}

yjd_install_base_packages() {

    return 0

}

yjd_install_desktop_packages() {

    return 0

}

yjd_install_fonts() {

    return 0

}

yjd_install_development_packages() {

    return 0

}

yjd_install_optional_packages() {

    return 0

}

yjd_package_summary() {

    printf "\n"

    printf "Installed : %d\n" "${YJD_PACKAGE_SUCCESS}"
    printf "Skipped   : %d\n" "${YJD_PACKAGE_SKIPPED}"
    printf "Failed    : %d\n" "${YJD_PACKAGE_FAILED}"

    printf "\n"

}