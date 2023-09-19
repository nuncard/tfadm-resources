// [.root] / [.aws] / [.region] / [vpc] /

# subnet

**Depends on:** [vpc-cidr-association](vpc-cidr-association.md)

**Extends:** [.vpc/tags-all](.vpc/tags-all.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] subnet [{environment}/{region}/{az}/{subnet_name}/{cidr_block}]...
tfadm COMMAND [OPTIONS] subnet [{domain}/vpcs/{vpc_name}/{region}/subnets/{subnet_name}]...
```

## Description

A subnet is a range of IP addresses in your VPC.

A subnet CIDR block must not overlap the CIDR block of an existing subnet in the VPC. After you create a subnet, you can't change its CIDR block.

The allowed size for an IPv4 subnet is between a `/28` netmask (16 IP addresses) and a `/16` netmask (65,536 IP addresses). AWS reserves both the first four and the last IPv4 address in each subnet's CIDR block. They're not available for your use.

If you add more than one subnet to a VPC, they're set up in a star topology with a logical router in the middle.

When you stop an instance in a subnet, it retains its private IPv4 address. It's therefore possible to have a subnet with no running instances (they're all stopped), but no remaining IP addresses available.

## Properties

- **`az`**

  The Availability Zone or Local Zone for the subnet (without region name prefix, e.g., `a`)

  *default: `a`*

- **`subnet_name`**

  The name of the subnet.

- **`SubnetId`**

  The ID of the subnet you want to sync with.

- **`cidr_block`**

  The IPv4 network range for the VPC, in CIDR notation. For example, `10.0.0.0/16`. You cannot specify an IPv4 CIDR block larger than `/16`.

- **`enable_lni_at_device_index`**

  Indicates the device position for local network interfaces in this subnet. For example, `1` indicates local network interfaces in this subnet are the secondary network interface (`eth1`). A local network interface cannot be the primary network interface (`eth0`).

- **`enable_resource_name_dns_a_record_on_launch`**

  Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default is `false`.

- **`map_public_ip_on_launch`**

  Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is `false`.

- **`private_dns_hostname_type_on_launch`**

  The type of hostnames to assign to instances in the subnet at launch. Valid values: `ip-name`, `resource-name`.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-subnets.sh "{profile}" "{region}" "Name=subnet-id,Values={SubnetId}" "Name=ipv6-native,Values=false" || \
.tfadm/bin/describe-subnets.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=tag:Name,Values={subnet_name}" "Name=availability-zone,Values={availability_zone}" "Name=ipv6-native,Values=false" || \
.tfadm/bin/describe-subnets.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId} Name=tag:Name,Values={subnet_name}" "Name=ipv6-native,Values=false" || \
.tfadm/bin/describe-subnets.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId} Name=availability-zone,Values={availability_zone}" "Name=ipv6-native,Values=false" || \
.tfadm/bin/describe-subnets.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=ipv6-native,Values=false"
```

### sync.when()

```yaml
subnet_name: dmz-*
```

### terraform.import()

```bash
terraform "-chdir={domain}/vpcs/{vpc_name}/{region}/subnets/{subnet_name}" import "-input=false" "aws_subnet.{subnet_id_}" "{SubnetId}"
```

## Events

### oninit

- **create**

  - [.subnet/providers]
  - [.subnet/versions]
  - [.subnet/vpc]

## Children

- [.subnet/elastic-ip]
  - [nat-gateway]
- [.subnet/providers]
- [.subnet/tags-all]
- [.subnet/versions]
- [.subnet/vpc]

## See Also

- [Terraform resource: `aws_subnet`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[.subnet/elastic-ip]: .subnet/elastic-ip.md
[.subnet/providers]: .subnet/providers.md
[.subnet/tags-all]: .subnet/tags-all.md
[.subnet/versions]: .subnet/versions.md
[.subnet/vpc]: .subnet/vpc.md
[nat-gateway]: nat-gateway.md
[vpc]: vpc.md
