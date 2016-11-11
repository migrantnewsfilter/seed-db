#!/bin/sh

HOST="${1:-localhost}"
BUCKET=migrantnews-app-db-dev-dumps

NEWS="$(aws s3 ls --no-sign-request s3://${BUCKET}/news/ | sort -r | head -n 1 | awk 'END {print $NF}' -)"
TERMS="$(aws s3 ls --no-sign-request s3://${BUCKET}/terms/ | sort -r | head -n 1 | awk 'END {print $NF}' -)"

aws s3 cp --no-sign-request s3://$BUCKET/news/$NEWS - | mongoimport -h $HOST --db newsfilter --collection news

aws s3 cp --no-sign-request s3://$BUCKET/terms/$TERMS - | mongoimport -h $HOST --db newsfilter --collection terms
