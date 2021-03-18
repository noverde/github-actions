#!/bin/bash

if [ -z "$AWS_DEFAULT_REGION" ]; then
    AWS_DEFAULT_REGION="us-east-1"
fi

mkdir -p ~/.aws

cat >> ~/.aws/config <<-EOF
    [default]
    region=$AWS_DEFAULT_REGION
EOF

cat >> ~/.aws/credentials <<-EOF
    [default]
    aws_access_key_id=$AWS_ACCESS_KEY_ID
    aws_secret_access_key=$AWS_SECRET_ACCESS_KEY
EOF

echo "::set-output name=random-id::$(echo $AWS_DEFAULT_REGION)"
