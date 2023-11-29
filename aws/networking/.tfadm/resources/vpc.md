// [.root] / [.aws] / [.region] /

# vpc

- **Depends on:** [dhcp-options]
- **Extends:** [.tags-all]

## Synopsis

```
tfadm COMMAND [OPTIONS] vpc [{environment}/{region}/{cidr_block}]...
tfadm COMMAND [OPTIONS] vpc [vpcs/{reversed_domain}/{vpc_name}/{region}]...
```

## Description

[Amazon Virtual Private Cloud (VPC)](https://aws.amazon.com/vpc/features/) is a service that lets you launch AWS resources in a logically isolated virtual network that you define. You have complete control over your virtual networking environment, including selection of your own IP address range, creation of subnets, and configuration of route tables and network gateways. You can use both IPv4 and IPv6 for most resources in your VPC, helping to ensure secure and easy access to resources and applications.

## Properties

- **`vpc_name`**

  The name of the VPC.

  *default: `{environment}`*

- **`VpcId`**

  The ID of the VPC you want to sync with.

- **`DhcpOptionsId`**

  The ID of the DHCP option set you want to sync with.

- **`cidr_block`**

  The IPv4 network range for the VPC, in CIDR notation. For example, `10.0.0.0/16`. You cannot specify an IPv4 CIDR block larger than `/16`.

- **`instance_tenancy`**
  
  The tenancy options for instances launched into the VPC. For `default`, instances are launched with shared tenancy by default. You can launch instances with any tenancy into a shared tenancy VPC. For `dedicated`, instances are launched as dedicated tenancy instances by default. You can only launch instances with a tenancy of `dedicated` or `host` into a dedicated tenancy VPC.

- **`enable_dns_support`**
  
  Whether DNS resolution through the Amazon DNS server is supported for the VPC. Defaults to `false`.

- **`enable_dns_hostnames`**

  Whether instances launched in the VPC receive public DNS hostnames that correspond to their public IP addresses. Defaults to `false`.

- **`enable_network_address_usage_metrics`**

  Whether Network Address Usage metrics are enabled for your VPC. Defaults to `false`.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-vpcs.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=tag-key,Values=Name" "Name=is-default,Values=false" || \
.tfadm/bin/describe-vpcs.sh "{profile}" "{region}" "Name=dhcp-options-id,Values={DhcpOptionsId}" "Name=tag-key,Values=Name" "Name=is-default,Values=false" || \
.tfadm/bin/describe-vpcs.sh "{profile}" "{region}" "Name=cidr-block-association.cidr-block,Values={cidr_block}" "Name=tag-key,Values=Name" "Name=is-default,Values=false"
```

### sync.list()

```bash
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=tag-key,Values=Name" "Name=is-default,Values=false" || \
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=dhcp-options-id,Values={DhcpOptionsId}" "Name=tag-key,Values=Name" "Name=is-default,Values=false" || \
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=cidr-block-association.cidr-block,Values={cidr_block}" "Name=tag-key,Values=Name" "Name=is-default,Values=false" || \
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=tag:Name,Values={vpc_name}" "Name=is-default,Values=false" || \
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=tag-key,Values=Name" "Name=is-default,Values=false"
```

### terraform.import()

```bash
terraform "-chdir=vpcs/{reversed_domain}/{vpc_name}/{region}" import "-input=false" "aws_vpc.this" "{VpcId}"
```

## Events

### oninit

- **create**

  - [.vpc/providers]
  - [.vpc/versions]

## Children

- [.internet-gateway]
- [.nat-gateway]
- [.vpc/providers]
- [.vpc/versions]
- [internet-gateway]
- [route-table]
- [security-group]
- [subnet]
- [vpc-cidr-association]
- [vpc-dhcp-association]

## Direct Sub-resources

- [.vpc/default](.vpc/default.md)


## See Also

- [Amazon VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [Terraform resource `aws_vpc`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)

[.aws]: ../../../.tfadm/resources/README.md
[.internet-gateway]: .internet-gateway.md
[.nat-gateway]: .nat-gateway.md
[.region]: ../../../.tfadm/resources/.region.md
[.root]: ../../../../.tfadm/resources/README.md
[.tags-all]: ../../../.tfadm/resources/.tags-all.md
[.vpc/providers]: .vpc/providers.md
[.vpc/versions]: .vpc/versions.md
[dhcp-options]: dhcp-options.md
[internet-gateway]: internet-gateway.md
[route-table]: route-table.md
[security-group]: security-group.md
[subnet]: subnet.md
[vpc-cidr-association]: vpc-cidr-association.md
[vpc-dhcp-association]: vpc-dhcp-association.md
