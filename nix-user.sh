#!/bin/sh

. ./config.sh
if ! test -e "$CONFIGURATION_FILE"; then
    echo "File $CONFIGURATION_FILE doesnt exist!"
    exit 1
fi

NIX_USER_DIR=$(dirname "$(readlink -f "$0")")
if ! test -d "/tmp/nix-user";then
  mkdir -p "/tmp/nix-user"
fi
export NIX_USER_DIR
case "$1" in
  help|-h)
    "${NIX_USER_DIR}/options/help.sh"
  ;;
  add-user|-a)
    "${NIX_USER_DIR}/options/add-user.sh" "$@"
  ;;
  delete-user|-d)
    "${NIX_USER_DIR}/options/delete-user.sh" "$@"
  ;;
  set-configuration|-c)
    sed -i "s/^CONFIGURATION_FILE=.*/CONFIGURATION_FILE=""$2""/" config.sh
  ;;
  update-user|-u)
    "${NIX_USER_DIR}/options/update-user.sh" "$@"
  ;;
  scan|-s)
    "${NIX_USER_DIR}/options/scan.sh"
  ;;
  *) echo "No such option $1! Run 'nix-user help' to see the list of available options!"
esac
