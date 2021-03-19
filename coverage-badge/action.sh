#!/bin/bash

coverage report
coverage report | tail -n1

# get total coverage
COVERAGE=`coverage report | tail -n1 | grep -o '\d*%' | cut -f1 -d'%'`

# color based on coverage (>95>90>85>80)
if [ $COVERAGE -ge 95 ]; then
    COLOR="brightgreen"
elif [ $COVERAGE -ge 90 ]; then
    COLOR="green"
elif [ $COVERAGE -ge 85 ]; then
     COLOR="yellowgreen"
elif [ $COVERAGE -ge 80 ]; then
    COLOR="yellow"
else 
    COLOR="red"
fi

SHIELDS_URL="https://img.shields.io/badge/coverage-${COVERAGE}%25-${COLOR}"
curl -s --output .coverage.svg ${SHIELDS_URL}
echo "File .coverage.svg created (${COVERAGE}% - ${COLOR})"
