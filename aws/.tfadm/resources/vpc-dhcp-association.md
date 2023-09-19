// [.root] / [.aws] / [.region] / [vpc] /

# vpc-dhcp-association

**Extends:** [.filter/dynamic](.filter/dynamic.md)

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

  The name of the DHCP option set to associate with the VPC.

  *default: `{vpc_name}`*

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-dhcp-options.sh "{profile}" "{region}" "Name=dhcp-options-id,Values={DhcpOptionsId}" || \
.tfadm/bin/describe-dhcp-options.sh "{profile}" "{region}" "Name=tag:Name,Values={dhcp_options_name}"
```

### sync.when() [^1]

```
dhcp_options_name | default(None) is not none
```

### terraform.import()

```bash
terraform "-chdir={domain}/vpcs/{vpc_name}/{region}" import "-input=false" "aws_vpc_dhcp_options_association.this" "{VpcId}"
```

## See Also

- [Terraform resource: `aws_vpc_dhcp_options_association`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association)

[^1]: [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[vpc]: vpc.md
