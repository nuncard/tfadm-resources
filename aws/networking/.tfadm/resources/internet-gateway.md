// [.root] / [.aws] / [.region] / [vpc] /

# internet-gateway

- **Extends:** [.vpc/tags-all]

## Synopsis

```
tfadm COMMAND [OPTIONS] internet-gateway [{environment}/{region}/{internet_gateway_name}]...
tfadm COMMAND [OPTIONS] internet-gateway [vpcs/{reversed_domain}/{vpc_name}/{region}]...
```

## Description

An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet. It supports IPv4 and IPv6 traffic. It does not cause availability risks or bandwidth constraints on your network traffic.

An internet gateway enables resources in your public subnets (such as EC2 instances) to connect to the internet if the resource has a public IPv4 address or an IPv6 address. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public IPv4 address or IPv6 address. For example, an internet gateway enables you to connect to an EC2 instance in AWS using your local computer.

## Properties

- **`internet_gateway_name`**

  The name of the Internet Gateway.

  *default: `{vpc_name}`*

- **`InternetGatewayId`**

  The ID of the internet gateway you want to sync with.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-internet-gateways.sh "{profile}" "{region}" "Name=attachment.vpc-id,Values={VpcId}" "Name=tag-key,Values=Name" || \
.tfadm/bin/describe-internet-gateways.sh "{profile}" "{region}" "Name=internet-gateway-id,Values={InternetGatewayId}" "Name=tag-key,Values=Name" || \
.tfadm/bin/describe-internet-gateways.sh "{profile}" "{region}" "Name=tag:Name,Values={internet_gateway_name}"
```

### terraform.import()

```bash
terraform "-chdir=vpcs/{reversed_domain}/{vpc_name}/{region}" import "-input=false" "aws_internet_gateway.this" "{InternetGatewayId}"
```

## See Also

- [Terraform resource: `aws_internet_gateway`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)

[.aws]: ../../../.tfadm/resources/README.md
[.region]: ../../../.tfadm/resources/.region.md
[.root]: ../../../../.tfadm/resources/README.md
[.vpc/tags-all]: .vpc/tags-all.md
[vpc]: vpc.md
