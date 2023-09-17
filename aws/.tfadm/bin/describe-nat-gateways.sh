#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filter="--filter $@"

describe() {
  local subnet_id=$(jq -r .SubnetId <<< "$1")
  echo "$1"
  aws ec2 describe-subnets --profile "$profile" --region "$region" --subnet-ids "$subnet_id" --query "Subnets[].{AvailabilityZone:AvailabilityZone,SubnetId:SubnetId,SubnetName:Tags[?Key=='Name'].Value|[0]}|[0]" --no-paginate --output json
}

aws ec2 describe-nat-gateways --profile "$profile" --region "$region" $filter --output json --no-paginate \
| jq -c '.NatGateways[] | if .Tags == null then . else (.Tags |= (map({(.Key): .Value}) | add)) end | . + (.NatGatewayAddresses[] | select(.IsPrimary == true) | {AllocationId,AssociationId,PrivateIp,PublicIp}) | .secondary_private_ip_addresses = (.NatGatewayAddresses | map(select(.IsPrimary==false))) | .secondary_private_ip_address_count = (.secondary_private_ip_addresses | length)' \
| while IFS= read -r nat; do describe "$nat" | jq -cs add; done \
| jq -s
