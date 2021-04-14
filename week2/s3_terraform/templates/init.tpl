#!/bin/bash

apt update && apt install awscli -y
aws s3 cp s3://${bucket_name}/${file_name} .