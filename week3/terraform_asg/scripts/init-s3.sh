#!/bin/bash

default_file_name='some.txt'
file_name=${1:-$default_file_name}

default_bucket_name='aws-4-dev-iidzikovskyi'
bucket_name=${2:-$default_bucket_name}

echo "some text data" > $file_name
aws --profile idzik s3api create-bucket \
--acl private \
--bucket $bucket_name \
--create-bucket-configuration '{"LocationConstraint": "us-west-2"}'
aws --profile idzik s3api put-bucket-versioning \
--bucket $bucket_name \
--versioning-configuration Status=Enabled
aws --profile idzik s3 cp $file_name s3://$bucket_name
