#!/usr/bin/env bash

set -Eeuo pipefail

readonly PROJECT_ROOT="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &&
    pwd
)"

# shellcheck source=utils/utils.sh
source "${PROJECT_ROOT}/scripts/utils/utils.sh"