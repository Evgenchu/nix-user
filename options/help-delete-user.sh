#!/bin/sh

cat <<'HELP'
Usage: nix-user -d|delete-user [options]

  --name "<string>"   The name for the user to be deleted

Examples:
  nix-user -d --name "John"
HELP
