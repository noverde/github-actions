#!/usr/bin/env bash

case "${GITHUB_REF}" in
	"refs/heads/main")
		ENV=production
		;;
	"refs/heads/staging")
		ENV=staging
		;;
	*)
		ENV=development
		;;
esac

echo "::set-output name=target-env::${ENV}"
