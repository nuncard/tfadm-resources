// [.root] / [.aws] / [.region] / [vpc] / [subnet] / [.subnet/elastic-ip] /

# nat-gateway

- **Extends:** [.tags-all](.tags-all.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] nat-gateway [{environment}/{region}/{az}/{subnet_name}/{nat_gateway_name}]...
tfadm COMMAND [OPTIONS] nat-gateway [{domain}/vpcs/{vpc_name}/{region}/subnets/{subnet_name}]...
```

## Description

You can use a Network Address Translation (NAT) gateway so that instances in a private subnet can connect to services outside your VPC but external services cannot initiate a connection with those instances.

## Properties

- **`nat_gateway_name`**

  The name of the NAT gateway.

  *default: `nat.{az}`*

- **`NatGatewayId`**

  The ID of the NAT gateway you want to sync with.

- **`connectivity_type`**

  Indicates whether the NAT gateway supports public or private connectivity. The default is public connectivity. Valid Values: `private`, `public`.

- **`private_ip`**

  The private IPv4 address to assign to the NAT gateway. If you don't provide an address, a private IPv4 address will be automatically assigned.

- **`secondary_private_ip_address_count`**

  The number of secondary private IPv4 addresses you want to assign to the NAT gateway.

- **`secondary_private_ip_addresses`**

  A list of secondary private IPv4 addresses to assign to the NAT Gateway.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-nat-gateways.sh "{profile}" "{region}" "Name=nat-gateway-id,Values={NatGatewayId}" "Name=tag-key,Values=Name" || \
.tfadm/bin/describe-nat-gateways.sh "{profile}" "{region}" "Name=subnet-id,Values={SubnetId}" "Name=tag-key,Values=Name" || \
.tfadm/bin/describe-nat-gateways.sh "{profile}" "{region}" "Name=tag:Name,Values={nat_gateway_name}" || \
.tfadm/bin/describe-nat-gateways.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=tag-key,Values=Name"
```

### terraform.import()

```bash
terraform "-chdir={domain}/vpcs/{vpc_name}/{region}/subnets/{subnet_name}" import "-input=false" "aws_nat_gateway.{nat_gateway_id_}" "{NatGatewayId}"
```

## Events

### onchange

- **update**
  - [.subnet/elastic-ip]

    ```yaml
    when: connectivity_type | default("public") == "public"
    ``` 

### onimport

- **terraform/import**
  - [.subnet/elastic-ip]

    ```yaml
    when: AllocationId is defined
    ``` 

## See Also

- [Terraform resource: `aws_nat_gateway`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)

[.aws]: README.md
[.region]: region.md
[.root]: ../../../.tfadm/resources/README.md
[.subnet/elastic-ip]: .subnet/elastic-ip.md
[Format String Syntax]: https://docs.python.org/3/library/string.html#format-string-syntax
[subnet]: subnet.md
[vpc]: vpc.md
