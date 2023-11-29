#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filter="--filter $@"

describe() {
  local nat subnet_id subnet cache=()

  while IFS= read -r nat; do
    subnet=''
    subnet_id=$(jq -r .SubnetId <<< "$nat")

    for subnet in ${cache[@]}; do
      subnet=$(fgrep "\"$subnet_id\"" <<< "$subnet") && break
    done

    if [[ -z "$subnet" ]]; then
      subnet=$(aws ec2 describe-subnets --profile "$profile" --region "$region" --subnet-ids "$subnet_id" --no-paginate --output json \
      | jq -c '.Subnets[] | {AvailabilityZone,SubnetId,"SubnetName":(.Tags // [] | .[] | select(.Key == "Name") | .Value)}')
      cache+=("$subnet")
    fi

    (echo "$nat"; echo "$subnet") | jq -cs add
  done

  return 0
}

aws ec2 describe-nat-gateways --profile "$profile" --region "$region" $filter --query NatGateways --no-paginate --output json \
| jq -c '.[] | .Tags |= (. // [] | map({(.Key): .Value}) | add) |
. + (.NatGatewayAddresses[] | select(.IsPrimary == true) | {AllocationId,AssociationId,PrivateIp,PublicIp}) |
.secondary_private_ip_addresses = (.NatGatewayAddresses | map(select(.IsPrimary==false) | .PrivateIp)) |
.secondary_private_ip_address_count = (.secondary_private_ip_addresses | length)' \
| describe \
| jq -s
