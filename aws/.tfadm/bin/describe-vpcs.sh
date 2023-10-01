#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

describe() {
  local vpc vpc_id attr

  while IFS= read -r vpc; do
    vpc_id=$(jq -r .VpcId <<< "$vpc")
    (
      echo "$vpc"
      for attr in enableDnsSupport enableDnsHostnames enableNetworkAddressUsageMetrics; do
        aws ec2 describe-vpc-attribute --profile "$profile" --region "$region" --vpc-id "$vpc_id" --attribute "$attr" --no-paginate --output json
      done
    ) | jq -cs add
  done

  return 0
}

aws ec2 describe-vpcs --profile "$profile" --region "$region" $filters --query 'Vpcs' --no-paginate --output json \
| jq -c ".[] | .Tags |= (. // [] | map({(.Key): .Value}) | add)" \
| describe \
| jq -s
