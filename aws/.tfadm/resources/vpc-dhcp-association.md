// [.root] / [.aws] / [.region] / [vpc] /

# vpc-dhcp-association

- **Extends:** [.filter/dynamic](.filter/dynamic.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] vpc-dhcp-association [{environment}/{region}/{dhcp_options_name}]...
tfadm COMMAND [OPTIONS] vpc-dhcp-association [{domain}/vpcs/{vpc_name}/{region}]...
```

## Description

Associates a set of DHCP options with the specified VPC.

Removing the DHCP options association automatically sets AWS's `default` DHCP options set to the VPC.

After you associate the options with the VPC, any existing instances and all new instances that you launch in that VPC use the options. You don''t need to restart or relaunch the instances. They automatically pick up the changes within a few hours, depending on how frequently the instance renews its DHCP lease. You can explicitly renew the lease using the operating system on the instance.

## Properties

- **`dhcp_options_name`**

  The name of the DHCP option set to associate with the VPC. Supports [Format String Syntax].

  *default: `{vpc_name}`*

  *use: `dynamic/filter/for_each/tag:Name`*

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-dhcp-options.sh "{profile}" "{region}" "Name=dhcp-options-id,Values={DhcpOptionsId}" "Name=tag-key,Values=Name" || \
.tfadm/bin/describe-dhcp-options.sh "{profile}" "{region}" "Name=tag:Name,Values={dhcp_options_name}"
```

### terraform.import()

```bash
terraform "-chdir={domain}/vpcs/{vpc_name}/{region}" import "-input=false" "aws_vpc_dhcp_options_association.this" "{VpcId}"
```

## See Also

- [Terraform resource: `aws_vpc_dhcp_options_association`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[Format String Syntax]: https://docs.python.org/3/library/string.html#format-string-syntax
[vpc]: vpc.md
