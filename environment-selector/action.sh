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

echo "::set-output name=target-env::${ENV} name=target-environment::${ENVIRONMENT}"
