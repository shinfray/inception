#!/bin/bash

# Directory to store secrets
SECRETS_DIR="./secrets"
# Array of file names for passwords
PASSWORD_FILES=("db_password" \
                "db_root_password" \
                "wp_root_user_password" \
                "wp_user_password")

# Function to generate a random password
generate_random_password() {
    LC_ALL=C tr -dc "[:alnum:]" </dev/urandom | head -c 12;
}

# Check if secrets directory exists, if not, create it
if [ ! -d "$SECRETS_DIR" ]; then
    mkdir -p "$SECRETS_DIR"
fi

# Loop through the array of password files
for file in "${PASSWORD_FILES[@]}"; do
    file_path="$SECRETS_DIR/$file"
    # Check if file exists, if not, create it and fill it with a random password
    if [ ! -f "$file_path" ]; then
        PASSWORD=$(generate_random_password)
        echo "$PASSWORD" > "$file_path"
        echo "Generated new $file: $PASSWORD"
    fi
done

if [ ! -f "$SECRETS_DIR/domain.crt" ] || [ ! -f "$SECRETS_DIR/domain.key" ]; then
        echo "domain.crt or domain.key is missing in $SECRETS_DIR. Update certificate"
        ./tools/update_ssl_certificate.sh
fi
