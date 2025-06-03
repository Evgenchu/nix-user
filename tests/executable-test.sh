#!/usr/bin/env bash
set -euo pipefail

echo "Running executable tests..."

if [ -z "${NIX_USER_PATH:-}" ]; then
    echo "ERROR: NIX_USER_PATH environment variable not set"
    exit 1
fi

if [ ! -x "$NIX_USER_PATH/bin/nix-user" ]; then
    echo "ERROR: nix-user binary is not executable at $NIX_USER_PATH/bin/nix-user"
    exit 1
fi

if [ ! -L "$NIX_USER_PATH/bin/nix-user" ]; then
    echo "ERROR: nix-user should be a symlink"
    exit 1
fi

if [ ! -f "$NIX_USER_PATH/bin/nix-user.sh" ]; then
    echo "ERROR: nix-user.sh target doesn't exist"
    exit 1
fi

if ! "$NIX_USER_PATH/bin/nix-user" help > /dev/null 2>&1; then
    echo "ERROR: nix-user help failed"
    exit 1
fi

if "$NIX_USER_PATH/bin/nix-user" 2>/dev/null; then
    echo "nix-user executed successfully"
else
    echo "ERROR: nix-user crashed unexpectedly"
    exit 1
fi

echo "All executable tests passed"
