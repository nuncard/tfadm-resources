#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

aws ec2 describe-subnets --profile "$profile" --region "$region" $filters --query Subnets --no-paginate --output json \
| jq 'map(.Tags |= (. // [] | map({(.Key): .Value}) | add))'
