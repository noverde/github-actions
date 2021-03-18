#!/bin/bash

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
