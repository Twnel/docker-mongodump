#!/bin/bash

set -ex

echo "Job started: $(date)"

DATE=$(date +%Y%m%d_%H%M%S)
FILE="/backup/backup-$PREFIX-$DATE.tar.gz"
LATEST="/latest-$PREFIX.tar.gz"

curl --data "S3 => $LATEST: started" "https://${SLACK_TEAM}.slack.com/services/hooks/slackbot?token=${SLACK_TOKEN}&channel=%23${SLACK_CHANNEL}"
mongodump --quiet --host $MONGO_PORT_27017_TCP_ADDR --port $MONGO_PORT_27017_TCP_PORT --db $DUMP_DB -u $MONGODB_ADMINUSERNAME -p $MONGODB_ADMINPASSWORD --authenticationDatabase admin
tar -zcvf $FILE dump/
rm -rf dump/
aws s3 cp ${FILE} s3://${S3_BUCKET}
aws s3 cp ${FILE} s3://${S3_BUCKET}${LATEST}
curl --data "S3 => $S3_BUCKET: $FILE" "https://${SLACK_TEAM}.slack.com/services/hooks/slackbot?token=${SLACK_TOKEN}&channel=%23${SLACK_CHANNEL}"
echo "Job finished: $(date)"
exit 0
