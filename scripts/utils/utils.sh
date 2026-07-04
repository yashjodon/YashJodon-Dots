#!/usr/bin/env bash

[[ "${YJD_UTILS_LOADED:-0}" == "1" ]] && return 0
readonly YJD_UTILS_LOADED=1

readonly YJD_UTILS_DIR="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &&
    pwd
)"

# shellcheck source=colors.sh
source "${YJD_UTILS_DIR}/colors.sh"

# shellcheck source=logger.sh
source "${YJD_UTILS_DIR}/logger.sh"

# shellcheck source=system.sh
source "${YJD_UTILS_DIR}/system.sh"

# shellcheck source=ui.sh
source "${YJD_UTILS_DIR}/ui.sh"

# shellcheck source=files.sh
source "${YJD_UTILS_DIR}/files.sh"

# shellcheck source=cleanup.sh
source "${YJD_UTILS_DIR}/cleanup.sh"

# shellcheck source=timer.sh
source "${YJD_UTILS_DIR}/timer.sh"