#!/bin/sh
check_conf () {
  if ! test -e "$CONFIGURATION_FILE"; then
    printf "File %s doen't exist! \n Use the command 'nix-user -c to change the configuration file!" "$CONFIGURATION_FILE"
    exit 1
  fi
}
