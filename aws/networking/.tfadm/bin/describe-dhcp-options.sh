#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

aws ec2 describe-dhcp-options --profile "$profile" --region "$region" $filters --query 'DhcpOptions' --no-paginate --output json \
| jq 'map(
  .DhcpConfigurations |= (map({(.Key): .Values | map(.Value)}) | add) |
  .DhcpConfigurations["domain-name"] |= .[0] |
  .Tags |= (. // [] | map({(.Key): .Value}) | add)
)'
