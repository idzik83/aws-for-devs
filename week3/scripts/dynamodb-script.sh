#!/bin/bash

table_name=$(aws dynamodb list-tables --region us-west-2 | jq -r '.TableNames[0]')
AWS_PAGER="" aws dynamodb put-item \
    --table-name aws-4-dev-iidzikovskyi  \
    --region us-west-2 \
    --item \
        '{"ID": {"S": "1"}, "Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}, "Awards": {"N": "1"}}'

AWS_PAGER="" aws dynamodb put-item \
  --table-name aws-4-dev-iidzikovskyi  \
  --region us-west-2 \
  --item \
      '{"ID": {"S": "2"}, "Artist": {"S": "Acme Band"}, "SongTitle": {"S": "Happy Day"}, "AlbumTitle": {"S": "Songs About Life"}, "Awards": {"N": "10"} }'
