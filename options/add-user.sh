#!/bin/sh

. ./config.sh
shift
while [ $# -gt 0 ]; do
  case "$1" in
    --help)
      "${NIX_USER_DIR}/options/help-add-user.sh"
      exit 0
    ;;
    --isNormalUser)
      isNormalUser=true
      shift
    ;;
    --description)
      shift
      DESCRIPTION="$1"
      shift
    ;;
    --home)
      shift
      USER_HOME="$1"
      shift
    ;;
    --group)
        shift
        GROUP="$1"
        shift
    ;;
    --uid)
        shift
        USER_UID="$1"
        shift
    ;;
    --name)
        shift
        USER_NAME="$1"
        shift
    ;;
    *) echo "Wrong parameter $1!"
      shift
  esac
done
: "${USER_HOME:?Missing --home}" "${USER_NAME:?Missing --name}"
file="$HOME/tmp/nix-user/$USER_NAME".nix

touch "$file"

cat << EOF > "$file"
  users.users.$USER_NAME = {
    ${DESCRIPTION:+description = \"$DESCRIPTION\";}
    ${isNormalUser:+isNormalUser = true;}
    ${USER_UID:+uid = $USER_UID;}
    ${GROUP:+group = \"$GROUP\";}
    ${USER_HOME:+home = \"$USER_HOME\";}
  };
EOF

awk NF "$file" > temp && mv temp "$file"
if grep -q "users.users.$USER_NAME" "$CONFIGURATION_FILE"; then
  echo "User $USER_NAME already exists. User configuration is saved in file $file!"
  echo "You can run the command 'nix-user -u $file' to update the existing configuration!"
  exit 1
fi
last_line=$(tail -n 1 "$CONFIGURATION_FILE")
sed -i '$d' "$CONFIGURATION_FILE"
cat "$file" >> "$CONFIGURATION_FILE"
echo "$last_line" >> "$CONFIGURATION_FILE"
echo "User $USER_NAME has been created!"
