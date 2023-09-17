// [.root](../root.md) / [.aws](./aws.md) / [.region](./region.md) / [vpc](./vpc.md) /

# internet-gateway

An internet gateway allows communication between your VPC and the internet.

An internet gateway is a horizontally scaled, redundant, and highly available VPC component. It supports IPv4 and IPv6 traffic. It does not cause availability risks or bandwidth constraints on your network traffic.

An internet gateway enables resources in your public subnets (such as EC2 instances) to connect to the internet if the resource has a public IPv4 address or an IPv6 address. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public IPv4 address or IPv6 address. For example, an internet gateway enables you to connect to an EC2 instance in AWS using your local computer.

## Usage

```
tfadm COMMAND [OPTIONS] internet-gateway [{environment}/{region}/{internet_gateway_name}]...
tfadm COMMAND [OPTIONS] internet-gateway [{domain}/vpcs/{vpc_name}/{region}]...
```

## Properties

- **`tags`**

  A map of tags to assign to the resource.

- **`internet_gateway_name`**

  The name of the Internet Gateway.

  *default: `{vpc_name}`*

- **`InternetGatewayId`**

  The ID of the internet gateway with which you want to sync.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-internet-gateways.sh "{profile}" "{region}" "Name=attachment.vpc-id,Values={VpcId}" || \
.tfadm/bin/describe-internet-gateways.sh "{profile}" "{region}" "Name=internet-gateway-id,Values={InternetGatewayId}" || \
.tfadm/bin/describe-internet-gateways.sh "{profile}" "{region}" "Name=tag:Name,Values={internet_gateway_name}"
```

### sync.when() [^1]

```
internet_gateway_name | default(None) is not none
```

### terraform.import()

```bash
terraform "-chdir={domain}/vpcs/{vpc_name}/{region}" import "-input=false" "aws_internet_gateway.this" "{InternetGatewayId}"
```

## See Also

- [Terraform resource: `aws_internet_gateway`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)

[^1]: [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)
