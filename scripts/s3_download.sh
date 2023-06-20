#!/bin/bash
BUCKET_NAME="your-bucket-name"
FILE_NAME="your-file-name"
DEST_PATH="/destination/path/for/file"

aws s3 cp s3://$BUCKET_NAME/$FILE_NAME $DEST_PATH
