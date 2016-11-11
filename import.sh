#!/bin/sh

HOST="${1:-localhost}"
BUCKET=migrantnews-app-db-dev-dumps

ALERTS="$(aws s3 ls --no-sign-request s3://${BUCKET}/alerts | sort -r | head -n 1 | awk 'END {print $NF}' -)"
FEEDS="$(aws s3 ls --no-sign-request s3://${BUCKET}/feeds | sort -r | head -n 1 | awk 'END {print $NF}' -)"

aws s3 cp --no-sign-request s3://$BUCKET/$ALERTS - | mongoimport -h $HOST --db newsfilter --collection alerts

aws s3 cp --no-sign-request s3://$BUCKET/$FEEDS - | mongoimport -h $HOST --db newsfilter --collection feeds
