#!/bin/sh

# Directory to store secrets
SECRETS_DIR="./secrets"

# Check if secrets directory exists, if not, create it
if [ ! -d "$SECRETS_DIR" ]; then
    mkdir -p "$SECRETS_DIR"
fi

openssl req -newkey rsa:2048 -nodes -keyout "$SECRETS_DIR/domain.key" -x509 -days 365 -out "$SECRETS_DIR/domain.crt"
# -subj "/C=BE/ST=Brussels/L=Brussels/O=19/OU=student/CN=shinfray.42.fr"
