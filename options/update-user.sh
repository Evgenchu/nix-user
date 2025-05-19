#!/bin/sh

. ./config.sh

if ! test -f "$2"; then
  echo "No such file $2!"
  exit 1
fi
USER_NAME=$(basename "$2" .nix)
if  grep -q "users.users.$USER_NAME" "$CONFIGURATION_FILE"; then
  sh options/delete-user.sh -t --name "$USER_NAME"
  last_line=$(tail -n 1 "$CONFIGURATION_FILE")
  sed -i '$d' "$CONFIGURATION_FILE"
  cat "$2" >> "$CONFIGURATION_FILE"
  echo "$last_line" >> "$CONFIGURATION_FILE"
  echo "User $USER_NAME has been updated!"
else
  echo "User doesn't exist in $CONFIGURATION_FILE!"
  exit 1
fi
