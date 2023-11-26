// [.root] / [.aws] / [.region] / [vpc] / [security-group] /

# security-group-rule

- **Extends:** [.vpc/tags-all](.vpc/tags-all.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] security-group-rule [{environment}/{region}/{security_group_name}/{type}/{ip_protocol}/{from_port}/{to_port}]...
tfadm COMMAND [OPTIONS] security-group-rule [vpcs/{reversed_domain}/{vpc_name}/{region}/security-groups/{security_group_name}]...
```

## Description

Represents an inbound (ingress) or outbound (egress) rule for a security group.

An inbound rule permits instances to receive traffic from the specified IPv4 or IPv6 CIDR address range, or from the instances that are associated with the specified source security groups.

An outbound rule permits instances to send traffic to the specified IPv4 or IPv6 CIDR address ranges, or to the instances that are associated with the specified destination security groups.

You specify a protocol for each rule (for example, TCP). For TCP and UDP, you must also specify the destination port or port range. For the ICMP protocol, you must also specify the ICMP type and code. You can use -1 for the type or code to mean all types or all codes.

Rule changes are propagated to instances within the security group as quickly as possible. However, a small delay might occur.

## Properties

- **`SecurityGroupRuleId`**

  The ID of the security group rule you want to sync with.

- **`description`**

  The description of the security group rule.

  *default: `Managed by Terraform`*

- **`type`**

  The type of the security group rule.

  Valid values: `in`, `inbound`, `ingress`, `out`, `outbound` or `egress`.

- **`ip_protocol`**

  The IP protocol name (`all`, `icmp`, `icmpv6`, `tcp`, `udp`) or number. (see [Protocol Numbers](http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml)).

  Use `all` to specify all protocols. For `tcp`, `udp`, and `icmp`, you must specify a port range. For `icmpv6`, the port range is optional; if you omit the port range, traffic for all types and codes is allowed.

- **`from_port`**

  The start of port range for the TCP and UDP protocols, or an ICMP type number.

- **`to_port`**

  The end of port range for the TCP and UDP protocols, or an ICMP code number.

One of the following source/destination arguments can be supplied:

- **`cidr_ipv4`**

  The IPv4 CIDR range. To specify a single IPv4 address, use the `/32` prefix length.

- **`cidr_ipv6`**

  The IPv6 CIDR range. To specify a single IPv6 address, use the `/128` prefix length.

- **`prefix_list_name`**

  The name of the source/destination prefix list. Supports [Format String Syntax].

- **`referenced_security_group_name`**

  The name of the source/destination security group.

The default is the security group itself.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-security-group-rules.sh "{profile}" "{region}" "Name=security-group-rule-id,Values={SecurityGroupRuleId}" || \
.tfadm/bin/describe-security-group-rules.sh "{profile}" "{region}" "Name=group-id,Values={SecurityGroupId}"
```

### terraform.import()

```bash
terraform "-chdir=vpcs/{reversed_domain}/{vpc_name}/{region}/security-groups/{security_group_name}" import "-input=false" "aws_vpc_security_group_{type}_rule.{security_group_rule_id_}" "{SecurityGroupRuleId}"
```

## Events

### oncreate

- **update**

  - [.security-group/referenced-group]

    ```yaml
    when: referenced_security_group_id is defined and referenced_security_group_id != security_group_id
    ```

  - [.security-group/prefix-list]:

    ```yaml
    when: prefix_list_name is defined
    ```

## See Also

- [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)
- [Terraform resource `aws_vpc_security_group_egress_rule`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule)
- [Terraform resource `aws_vpc_security_group_ingress_rule`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[.security-group/prefix-list]: .security-group/prefix-list.md
[.security-group/referenced-group]: .security-group/referenced-group.md
[Format String Syntax]: https://docs.python.org/3/library/string.html#format-string-syntax
[security-group]: security-group.md
[vpc]: vpc.md
