#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

aws ec2 describe-security-groups --profile "$profile" --region "$region" $filters --query 'SecurityGroups' --no-paginate --output json \
| jq 'map(
  del(.IpPermissions) |
  del(.IpPermissionsEgress) |
  .Tags |= (. // [] | map({(.Key): .Value}) | add)
)'
