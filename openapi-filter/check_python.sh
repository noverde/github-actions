#!/usr/bin/env bash

if command -v python3 &> /dev/null
then
	PYTHON_INSTALLED="yes"
else
	PYTHON_INSTALLED="no"
fi

echo "installed=$PYTHON_INSTALLED" >> $GITHUB_OUTPUT
