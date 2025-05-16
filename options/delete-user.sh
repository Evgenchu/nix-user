#!/bin/sh

. ./config.sh

if [ "$2" = "--name" ]; then
  sed -i '/users.users.'"$3/"',/  };/d' "$CONFIGURATION_FILE"
  echo "User $3 has been deleted!"
elif [ "$2" = "--help" ]; then
  "${NIX_USER_DIR}/options/help-delete-user.sh"
fi
