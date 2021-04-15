#!/bin/bash

apt update && apt install awscli jq postgresql-client -y
aws s3 cp s3://${bucket_name}/dynamodb-script.sh .
aws s3 cp s3://${bucket_name}/rds-script.sql .