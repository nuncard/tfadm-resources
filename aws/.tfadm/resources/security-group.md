// [.root] / [.aws] / [.region] / [vpc] /

# security-group

- **Extends:** [.vpc/tags-all](.vpc/tags-all.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] security-group [{environment}/{region}/{security_group_name}]...
tfadm COMMAND [OPTIONS] security-group [vpcs/{reversed_domain}/{vpc_name}/{region}/security-groups/{security_group_name}]...
```

## Description

A security group acts as a virtual firewall for your instances to control inbound and outbound traffic.

## Properties

- **`security_group_name`**

  The name of the security group. Cannot start with `sg-`. Supports [Format String Syntax].

  *use: `tags/Name`*

- **`SecurityGroupId`**

  The ID of the Security Group you want to sync with.

- **`SecurityGroupName`**

  The name of the Security Group you want to sync with.

- **`description`**

  A description for the security group. This is informational only. Defaults to `Managed by Terraform`. Cannot be `""`.

- **`revoke_rules_on_delete`**

  Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Defaults to `false`.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-security-groups.sh "{profile}" "{region}" "Name=group-id,Values={SecurityGroupId}" || \
.tfadm/bin/describe-security-groups.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=group-name,Values={SecurityGroupName}" || \
.tfadm/bin/describe-security-groups.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=tag:Name,Values={security_group_name}" || \
.tfadm/bin/describe-security-groups.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}"
```

### terraform.import()

```bash
terraform "-chdir=vpcs/{reversed_domain}/{vpc_name}/{region}/security-groups/{security_group_name}" import "-input=false" "aws_security_group.this" "{SecurityGroupId}"
```

## Events

### oninit

- **create**

  - [.security-group/providers]
  - [.security-group/versions]
  - [.security-group/vpc]

## Children

- [.security-group/providers]
- [.security-group/referenced-group]
- [.security-group/versions]
- [.security-group/vpc]
- [security-group-rule]


## See Also

- [Terraform resource: `aws_security_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[.security-group/providers]: .security-group/providers.md
[.security-group/referenced-group]: .security-group/referenced-group.md
[.security-group/versions]: .security-group/versions.md
[.security-group/vpc]: .security-group/vpc.md
[Format String Syntax]: https://docs.python.org/3/library/string.html#format-string-syntax
[security-group-rule]: security-group-rule.md
[vpc]: vpc.md
