#!/usr/bin/bash
# This script is used as the entry point for the docker image.
# It will initialize the database if it isn't already present.

# Creating certificates
if [ ! -f "$SRP_ROOT/certs/key.pem" [; then
    echo "No certs, creating..."
    openssl req -x509 -newkey rsa:4096 -nodes -keyout $SRP_ROOT/certs/key.pem -out $SRP_ROOT/certs/cert.pem -days 1095
fi

if [ ! -f "$SRP_ROOT/db/master.db" ]; then
    echo "First run detected. Initializing database..."
    ruby "$SRP_ROOT/scripts/first_time.rb"
fi

# CMD ["ruby", "serpico.rb"]
ruby serpico.rb

