#!/bin/bash

DATE=$(date +%Y-%m-%d_%H-%M-%S)
mkdir -p backups/incremental/$DATE
cp query.js query.js.$DATE
mongodump -h localhost -d local -c oplog.rs --queryFile query.js --port 27017 -o - > backups/incremental/$DATE/oplog.bson
CURRENT_DATE=$(date +%s)
PREVIOUS_DATE=$(cat query.js | awk -F: '{print $6}' | cut -c 1-10)
sed -i "s|$PREVIOUS_DATE|$CURRENT_DATE|g" query.js
