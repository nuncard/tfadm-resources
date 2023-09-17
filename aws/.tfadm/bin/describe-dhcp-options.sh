#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

aws ec2 describe-dhcp-options --profile "$profile" --region "$region" $filters --output json --no-paginate \
| jq '.DhcpOptions | map(.DhcpConfigurations |= (map({(.Key): .Values | map(.Value)}) | add) |.DhcpConfigurations["domain-name"] |= .[0] | .Tags |= (if . == null then . else (map({(.Key): .Value}) | add) end))'
