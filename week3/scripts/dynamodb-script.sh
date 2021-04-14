#!/bin/bash

#apt-get update && apt-get install jq
table_name=$(aws dynamodb idzik list-tables | jq -r '.TableNames[0]')
AWS_PAGER="" aws dynamodb put-item \
    --table-name $table_name  \
    --item \
        '{"id": {"S": "5"}, "Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}, "Awards": {"N": "1"}}'

AWS_PAGER="" aws dynamodb put-item \
  --table-name $table_name  \
  --item \
      '{"id": {"S": "6"}, "Artist": {"S": "Acme Band"}, "SongTitle": {"S": "Happy Day"}, "AlbumTitle": {"S": "Songs About Life"}, "Awards": {"N": "10"} }'
