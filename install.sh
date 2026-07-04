#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
#
# Main Installer
#
# Author : YashJodon
# License: MIT
# ==========================================================

set -Eeuo pipefail

# ----------------------------------------------------------
# Project Information
# ----------------------------------------------------------

readonly PROJECT_NAME="YashJodon-Dots"
readonly PROJECT_VERSION="0.1.0"

# ----------------------------------------------------------
# Project Root
# ----------------------------------------------------------
PROJECT_ROOT="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &&
    pwd
)"

readonly PROJECT_ROOT
# ----------------------------------------------------------
# Load Framework
# ----------------------------------------------------------

# shellcheck source=scripts/bootstrap.sh
source "${PROJECT_ROOT}/scripts/bootstrap.sh"

# ----------------------------------------------------------
# Main
# ----------------------------------------------------------

main() {

    yjd_require_bash

    yjd_header

    yjd_log_info "Starting ${PROJECT_NAME} ${PROJECT_VERSION}"

    if ! yjd_check_internet; then

        yjd_log_error "Internet connection not available."

        exit 1

    fi

    yjd_log_success "Internet connection detected."

    yjd_log_info "Detecting shell..."

    yjd_log_success "Shell: $(yjd_detect_shell)"

    yjd_log_info "Checking required commands..."

    yjd_require_command git
    yjd_require_command bash

    yjd_log_success "Environment looks good."

    yjd_newline

    yjd_section "Installation Plan"

    printf "Project : %s\n" "${PROJECT_NAME}"
    printf "Version : %s\n" "${PROJECT_VERSION}"

    yjd_newline

    if ! yjd_confirm "Continue installation?"; then

        yjd_log_warning "Installation cancelled by user."

        exit 0

    fi

    yjd_newline

    yjd_log_info "Installer framework is ready."

    yjd_log_info "Next stages will be implemented in upcoming modules."

    yjd_newline

    yjd_log_success "Bootstrap completed successfully."

}

main "$@"