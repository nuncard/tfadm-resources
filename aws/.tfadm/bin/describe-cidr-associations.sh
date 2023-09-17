#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

aws ec2 describe-vpcs --profile "$profile" --region "$region" $filters --query 'Vpcs[]' --no-paginate --output json \
| jq 'map(.VpcId as $vpc_id | .CidrBlock as $cidr_block | (.Tags // [] | map({(.Key): .Value}) | add) as $tags | .CidrBlockAssociationSet | map(select(.CidrBlock != $cidr_block) | [., {Tags: $tags, VpcId: $vpc_id}] | add)) | flatten'
