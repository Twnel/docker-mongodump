#!/bin/bash

set -e

echo "Job started: $(date)"

DATE=$(date +%Y%m%d_%H%M%S)
FILE="/backup/backup-$DATE.tar.gz"

mongodump --quiet -h $MONGO_PORT_27017_TCP_ADDR -p $MONGO_PORT_27017_TCP_PORT --db $DUMP_DB -u $MONGODB_ADMINUSERNAME -p $MONGODB_ADMINPASSWORD --authenticationDatabase admin
tar -zcvf $FILE dump/
rm -rf dump/
aws s3 cp ${FILE} s3://${S3_BUCKET} 

echo "Job finished: $(date)"
