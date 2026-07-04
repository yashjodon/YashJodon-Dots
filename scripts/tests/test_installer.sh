#!/usr/bin/env bash

set -Eeuo pipefail

echo
echo "===== INSTALLER TEST ====="
echo

bash -n install.sh

echo "Syntax OK"

shellcheck -x install.sh

echo "ShellCheck OK"

echo

echo "PASS"