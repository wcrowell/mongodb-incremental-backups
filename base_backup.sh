#!/bin/bash

DATE=$(date +%Y-%m-%d_%H-%M-%S)
cp query.js query.js.$DATE
mongodump -h localhost --port 27017 -d trucking -o backups/base
CURRENT_DATE=$(date +%s)
PREVIOUS_DATE=$(cat query.js | awk -F: '{print $6}' | cut -c 1-10)
sed -i "s|$PREVIOUS_DATE|$CURRENT_DATE|g" query.js
