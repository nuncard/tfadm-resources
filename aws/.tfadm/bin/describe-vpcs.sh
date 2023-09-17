#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

describe() {
  local vpc_id=$(jq -r .VpcId <<< "$1")
  echo "$1"

  for attr in enableDnsSupport enableDnsHostnames enableNetworkAddressUsageMetrics; do
    aws ec2 describe-vpc-attribute --profile "$profile" --region "$region" --vpc-id "$vpc_id" --attribute "$attr" --no-paginate --output json
  done
}

aws ec2 describe-vpcs --profile "$profile" --region "$region" $filters --no-paginate --output json \
| jq -c ".Vpcs[] | if .Tags == null then . else (.Tags |= (map({(.Key): .Value}) | add)) end" \
| while IFS= read -r vpc; do describe "$vpc" | jq -cs add; done | jq -s
