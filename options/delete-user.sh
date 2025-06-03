#!/bin/sh

. ./config.sh
. ./utils/functions.sh
if [ "$2" = "--name" ]; then
  check_conf
  if ! grep -q "users.users.$3" "$CONFIGURATION_FILE"; then
    echo "User $3 is not in $CONFIGURATION_FILE!"
    exit 1
  fi
  sed -i '/users.users.'"$3/"',/  };/d' "$CONFIGURATION_FILE"
  if ! [ "$1" = "-t" ];then
  echo "User $3 has been deleted!"
  fi
elif [ "$2" = "--help" ]; then
  "${NIX_USER_DIR}/options/help-delete-user.sh"
else
  echo "No such parameter $2!"
  exit 1
fi
