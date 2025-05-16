#!/bin/sh

cat <<'HELP'
Usage: nix-user -a|add-user [options]

Options:
  --isNormalUser              Is the user normal or system
  --description "<string>"    User description
  --home        "<string>"    Home dir of the user
  --group       "<string>"    Default group of the user
  --uid           "<int>"     User UID
  --name        "<string>"    Name of the user

Examples:
  nix-user -a --name "John" --description "Account for John" --isNormalUser --home "/home/John/" --uid "1001" --group "wheel"
HELP
