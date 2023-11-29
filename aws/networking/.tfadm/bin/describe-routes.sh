#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

describe() {
  local route target_id target cache=()

  while IFS= read -r route; do
    target=''
    target_id=$(jq -r .InternetGatewayId <<< "$route")
    [[ "$target_id" != 'null' ]] || target_id=$(jq -r .NatGatewayId <<< "$route")
    # [[ "$target_id" != 'null' ]] || target_id=$(jq -r .TransitGatewayId <<< "$route")
    [[ "$target_id" != 'null' ]] || continue

    for target in ${cache[@]}; do
      target=$(fgrep "\"$target_id\"" <<< "$target") && break
    done

    if [[ -z "$target" ]]; then
      case "$target_id" in
        igw-*)
          target=$(aws ec2 describe-internet-gateways --profile "$profile" --region "$region" --internet-gateway-ids "$target_id" --no-paginate --output json \
          | jq -c '.InternetGateways[] | {InternetGatewayId,"InternetGatewayName":(.Tags // [] | .[] | select(.Key == "Name") | .Value)}');;
        nat-*)
          target=$(aws ec2 describe-nat-gateways --profile "$profile" --region "$region" --nat-gateway-ids "$target_id" --no-paginate --output json \
          | jq -c '.NatGateways[] | {NatGatewayId,"NatGatewayName":(.Tags // [] | .[] | select(.Key == "Name") | .Value)}');;
        # tgw-*)
        #   target=$(aws ec2 describe-transit-gateways --profile "$profile" --region "$region" --transit-gateway-ids "$target_id" --no-paginate --output json \
        #   | jq -c '.TransitGateways[] | {TransitGatewayId,"TransitGatewayName":(.Tags // [] | .[] | select(.Key == "Name") | .Value)}');;
      esac

      cache+=("$target")
    fi

    (echo "$route"; echo "$target") | jq -cs add
  done

  return 0
}

aws ec2 describe-route-tables --profile "$profile" --region "$region" $filters --query 'RouteTables' --no-paginate --output json \
| jq -c '.[] |
. + (.Associations | (.[] | select(.Main == true) | {Main}) // {"Main": false}) |
.Tags = (.Tags // [] | map({(.Key): .Value}) | add) |
if .Main == true and .Tags.Name == null then .Tags.Name = "main" else . end |
.RouteTableId as $route_table_id |
.Tags as $tags |
.Routes[] |
select(.Origin == "CreateRoute") |
[., {Tags: $tags, RouteTableId: $route_table_id}] |
add |
if .GatewayId != null and (.GatewayId | startswith("igw-")) then .InternetGatewayId = .GatewayId else . end' \
| describe \
| jq -s 'map(select(. != null))'
