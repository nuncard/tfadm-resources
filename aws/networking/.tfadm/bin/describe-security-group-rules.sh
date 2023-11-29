#!/usr/bin/env bash
set -e -o pipefail

profile=$1
shift
region=$1
shift
[[ $# -eq 0 ]] || filters="--filters $@"

describe() {
  local rule obj_id obj cache=()

  while IFS= read -r rule; do
    obj_id=$(jq -r .ReferencedGroupInfo.GroupId <<< "$rule")
    [[ "$obj_id" != 'null' ]] || obj_id=$(jq -r .PrefixListId <<< "$rule")

    if [[ "$obj_id" == 'null' ]]; then
      echo "$rule"
    else
      obj=''

      for obj in ${cache[@]}; do
        obj=$(fgrep "\"$obj_id\"" <<< "$obj") && break
      done

      if [[ -z "$obj" ]]; then
        case "$obj_id" in
          sg-*)
            obj=$(aws ec2 describe-security-groups --profile "$profile" --region "$region" --group-ids "$obj_id" --no-paginate --output json \
            | jq -c '.SecurityGroups[] | {"ReferencedSecurityGroupId":.GroupId,"ReferencedSecurityGroupName":.GroupName,"referenced_security_group_name":((.Tags // [] | .[] | select(.Key == "Name") | .Value) // null)}');;
          pl-*)
            obj=$(aws ec2 describe-managed-prefix-lists --profile "$profile" --region "$region" --prefix-list-ids "$obj_id" --no-paginate --output json \
            | jq -c '.PrefixLists[] | {PrefixListId,PrefixListName}');;
        esac

        cache+=("$obj")
      fi

      (echo "$rule"; echo "$obj") | jq -cs add
    fi
  done

  return 0
}

aws ec2 describe-security-group-rules --profile "$profile" --region "$region" $filters --query 'SecurityGroupRules' --no-paginate --output json \
| jq -c '.[] | .Tags |= (. // [] | map({(.Key): .Value}) | add)' \
| describe \
| jq -s
