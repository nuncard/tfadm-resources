// [.root](../root.md) / [.aws](./aws.md) / [.region](./region.md) /

# vpc

A VPC is an isolated portion of the AWS Cloud.

## Usage

```
tfadm COMMAND [OPTIONS] vpc [{environment}/{region}/{cidr_block}]...
tfadm COMMAND [OPTIONS] vpc [{domain}/vpcs/{vpc_name}/{region}]...
```

## Properties

- **`tags`**

  A map of tags to assign to the resource.

- **`vpc_name`**

  The name of the VPC.

  *default: `{environment}`*

- **`VpcId`**

  The ID of the VPC with which you want to sync.

- **`DhcpOptionsId`**

  The ID of the DHCP option set with which you want to sync.

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
.tfadm/bin/describe-vpcs.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=is-default,Values=false" || \
.tfadm/bin/describe-vpcs.sh "{profile}" "{region}" "Name=dhcp-options-id,Values={DhcpOptionsId}" "Name=is-default,Values=false" || \
.tfadm/bin/describe-vpcs.sh "{profile}" "{region}" "Name=cidr-block-association.cidr-block,Values={cidr_block}" "Name=is-default,Values=false" || \
.tfadm/bin/describe-vpcs.sh "{profile}" "{region}" "Name=tag:Name,Values={vpc_name}" "Name=is-default,Values=false"
```

### sync.list()

```bash
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=is-default,Values=false" || \
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=dhcp-options-id,Values={DhcpOptionsId}" "Name=is-default,Values=false" || \
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=cidr-block-association.cidr-block,Values={cidr_block}" "Name=is-default,Values=false" || \
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=tag:Name,Values={vpc_name}" "Name=is-default,Values=false" || \
.tfadm/bin/list-vpcs.sh "{profile}" "{region}" "Name=is-default,Values=false"
```

### sync.when() [^1]

```
vpc_name | default(None) is not none
```

### terraform.import()

```bash
terraform "-chdir={domain}/vpcs/{vpc_name}/{region}" import "-input=false" "aws_vpc.this" "{VpcId}"
```

## Events

### oninit

- **create**
  - .vpc/providers
  - .vpc/versions

## See Also

- [Terraform resource: `aws_vpc`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)

[^1]: [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)
