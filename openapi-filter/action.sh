#!/usr/bin/env bash

OUT="filtered_$(basename $FILE)"
ARGS="-o $OUT"

if [ "$EXCLUDE_EXT" = "yes" ]
then
	ARGS="$ARGS -x"
fi

if [ "$PATHS" != "" ]
then
	ARGS="$ARGS -p $PATHS"
fi

if [ "$TAGS" != "" ]
then
	ARGS="$ARGS -t $TAGS"
fi


openapi_filter $ARGS $FILE

echo "file=$OUT" >> $GITHUB_OUTPUT
