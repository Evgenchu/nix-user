#!/bin/sh

NIX_USER_DIR=$(dirname "$(readlink -f "$0")")
. "$NIX_USER_DIR/config.sh"
. "$NIX_USER_DIR/utils/functions.sh"
if ! test -d "/tmp/nix-user";then
  mkdir -p "/tmp/nix-user"
fi
export NIX_USER_DIR
case "$1" in
  help|-h|"")
    "${NIX_USER_DIR}/options/help.sh"
  ;;
  add-user|-a)
    "${NIX_USER_DIR}/options/add-user.sh" "$@"
  ;;
  delete-user|-d)
    "${NIX_USER_DIR}/options/delete-user.sh" "$@"
  ;;
  set-configuration|-c)
    if grep -q "^export CONFIGURATION_FILE=" "$NIX_USER_DIR/config.sh"; then
      sed -i "s|^export CONFIGURATION_FILE=.*|export CONFIGURATION_FILE=\"$2\"|" "$NIX_USER_DIR/config.sh"
    else
      echo "export CONFIGURATION_FILE=\"$2\"" >> config.sh
    fi
   ;;
  update-user|-u)
    check_conf
    "${NIX_USER_DIR}/options/update-user.sh" "$@"
  ;;
  scan|-s)
    check_conf
    "${NIX_USER_DIR}/options/scan.sh"
  ;;
  clean-cache|-g)
    rm -r /tmp/nix-user
    echo "Cache cleared successfully!"
  ;;
  *)
    echo "No such option $1! Run 'nix-user help' to see the list of available options!"
    exit 1
esac
