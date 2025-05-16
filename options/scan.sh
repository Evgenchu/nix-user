#!/bin/sh

. ./config.sh
while IFS=: read -r username password uid gid comment homedir shell; do
    if [ "$uid" -ge 1000 ] && [ "$uid" -lt 30000 ] && ! grep -q "users.users.$username" "$CONFIGURATION_FILE" ;then
      echo "Found user $username!"
      sh options/add-user.sh -s --name "$username" --home "$homedir" --uid "$uid" --description "$comment" --isNormalUser
    fi
done < /etc/passwd
