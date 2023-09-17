#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

aws ec2 describe-internet-gateways --profile "$profile" --region "$region" $filters --output json --no-paginate \
| jq '.InternetGateways | map(if .Tags == null then . else (.Tags |= (map({(.Key): .Value}) | add)) end)'
