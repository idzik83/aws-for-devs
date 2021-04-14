#!/bin/bash

default_bucket_name='aws-4-dev-iidzikovskyi'
bucket_name=${1:-$default_bucket_name}

aws s3 mb s3://${bucket_name} --profile idzik
aws s3 cp dynamodb-script.sh s3://${bucket_name}/dynamodb-script.sh --profile idzik
aws s3 cp rds-script.sql s3://${bucket_name}/rds-script.sql --profile idzik
