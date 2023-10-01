#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

aws ec2 describe-route-tables --profile "$profile" --region "$region" $filters --query 'RouteTables' --no-paginate --output json \
| jq 'map(
  del(.Routes) |
  . + (.Associations | (.[] | select(.Main == true) | {Main, RouteTableAssociationId}) // {"Main": false}) |
  del(.Associations) |
  .Tags |= (. // [] | map({(.Key): .Value}) | add) |
  if .Main == true and .Tags.Name == null then .Tags.Name = "main" else . end
)'
