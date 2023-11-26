// [.root] / [.aws] / [.region] /

# prefix-list

- **Extends:** [.tags-all](.tags-all.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] prefix-list [{environment}/{region}/{address_family}/{hostname}/{domain}/{cidr_block}]...
tfadm COMMAND [OPTIONS] prefix-list [prefix-lists/{prefix_list_name}/{region}]...
```

## Description

A managed prefix list is a set of one or more CIDR blocks.

You can use prefix lists to make it easier to configure and maintain your security groups and route tables. You can create a prefix list from the IP addresses that you frequently use, and reference them as a set in security group rules and routes instead of referencing them individually.

For example, you can consolidate security group rules with different CIDR blocks but the same port and protocol into a single rule that uses a prefix list. If you scale your network and need to allow traffic from another CIDR block, you can update the relevant prefix list and all security groups that use the prefix list are updated. You can also use managed prefix lists with other AWS accounts using Resource Access Manager (RAM).

## Properties

- **`domain`**

  Root domain name used to identify services provided through the Internet. Cannot be `amazonaws.com`.

- **`hostname`**

  The name of the host. Supports [Format String Syntax].

  *default: `{region}.{environment}`*

  *use: `tags/Name`*

- **`address_family`**

  The IP address type. Valid values: `IPv4` or `IPv6`.

  *default: `IPv4`*

- **`prefix_list_name`**

  A name for the prefix list, up to 255 characters in length. Cannot start with `com.amazonaws`.

  *use: `name`*

- **`PrefixListId`**
  
  The ID of the Prefix List you want to sync with.

- **`cidr_block`**
  
  The CIDR block.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-managed-prefix-lists.sh "{profile}" "{region}" "Name=prefix-list-id,Values={PrefixListId}" || \
.tfadm/bin/describe-managed-prefix-lists.sh "{profile}" "{region}" "Name=prefix-list-name,Values={prefix_list_name}" || \
.tfadm/bin/describe-managed-prefix-lists.sh "{profile}" "{region}"
```

### sync.when()

```
prefix_list_name is string and not prefix_list_name.startswith("com.amazonaws.")
```

### terraform.import()

```bash
terraform "-chdir=prefix-lists/{prefix_list_name}/{region}" import "-input=false" "aws_ec2_managed_prefix_list.this" "{PrefixListId}"
```

## Events

### oninit

- **create**

  - [.prefix-list/providers]
  - [.prefix-list/variables]
  - [.prefix-list/versions]

### onchange

- **update**

  - [prefix-list-entry]

    ```yaml
    when: cidr_block is string
    ```

## Children

- [.prefix-list/providers]
- [.prefix-list/variables]
- [.prefix-list/versions]
- [prefix-list-entry]

## See Also

- [Group CIDR blocks using managed prefix lists](https://docs.aws.amazon.com/vpc/latest/userguide/managed-prefix-lists.html)
- [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)
- [Terraform resource `aws_ec2_managed_prefix_list`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list)

[.aws]: README.md
[.prefix-list/providers]: .prefix-list/providers.md
[.prefix-list/versions]: .prefix-list/versions.md
[.prefix-list/variables]: .prefix-list/variables.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[Format String Syntax]: https://docs.python.org/3/library/string.html#format-string-syntax
[prefix-list-entry]: prefix-list-entry.md
