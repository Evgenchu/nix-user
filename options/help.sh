#!/bin/sh

cat <<'HELP'
Usage: nix-user [options]

Options:
  -h, help                   Show this help message
  -a, add-user               Create a user
  -d, delete-user            Delete a user
  -c, set-configuration      Change the configuration file for the program
  -s, scan                   Generate code for existing users and add it to the configuration
  -u, update-user            Update a user
  -g, clean-cache            Clean the cache created by the program
Examples:
  nix-user -a --help          Create user help menu
  nix-user -d --help          Delete user help menu
  nix-user -c "/foo/bar.nix"  Change the configuration file
  nix-user -s                 Automatically update the user system code
  nix-user -u "john.nix"      Create or modify the 'John' user configuration

HELP
