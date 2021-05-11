#!/bin/bash

# set amplify branch from git branch if not defined
if [ -z "$AMPLIFY_BRANCH" ]; then
    AMPLIFY_BRANCH=$(basename $GITHUB_REF)
fi

# source url 
if [ -z "$AMPLIFY_SOURCE_URL" ]; then
    AMPLIFY_SOURCE_URL="$AMPLIFY_BUCKET/$GITHUB_REPOSITORY/$AMPLIFY_BRANCH/$GITHUB_SHA.zip"
fi

cd $AMPLIFY_DIST_PATH
zip -r $GITHUB_SHA.zip *
aws s3 cp $GITHUB_SHA.zip $AMPLIFY_SOURCE_URL

aws amplify start-deployment --app-id $AMPLIFY_APP_ID --branch-name $AMPLIFY_BRANCH --source-url $AMPLIFY_SOURCE_URL 
