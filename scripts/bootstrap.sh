#!/usr/bin/env bash

set -Eeuo pipefail

readonly PROJECT_ROOT="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &&
    pwd
)"

# shellcheck source=utils/utils.sh
source "${PROJECT_ROOT}/scripts/utils/utils.sh"
# shellcheck source=scripts/modules/distro.sh
source "${PROJECT_ROOT}/scripts/modules/distro.sh"

