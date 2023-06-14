#!/usr/bin/env bash

case "${GITHUB_REF}" in
	"refs/heads/main")
		ENV=prd;
		ENVIRONMENT=production
		;;
	"refs/heads/staging")
		ENV=stg;
		ENVIRONMENT=staging
		;;
	*)
		ENV=dev;
		ENVIRONMENT=development
		;;
esac

echo "target-env=${ENV}" >> $GITHUB_OUTPUT
echo "target-environment=${ENVIRONMENT}" >> $GITHUB_OUTPUT
