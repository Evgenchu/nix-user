#!/bin/sh

cat <<'HELP'
Usage: nix-user [options]

Options:
  -h, help          Show this help message
  -a, add-user      Create a user
  -d, delete-user   Delete a user
  -s, set-file      Change the configuration file for the program
Examples:
  nix-user -h          Show this help message
  nix-user -a --help   Create a user help menu
  nix-user -d --help
  nix-user -s "/etc/nixos-john/configuration.nix"
HELP
