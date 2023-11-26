// [.root] / [.aws] / [.region] / [vpc] / [route-table] /

# route

- **Extends:** [.vpc/tags-all](.vpc/tags-all.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] route-table [{environment}/{region}/{route_table_name}]...
tfadm COMMAND [OPTIONS] route-table [vpcs/{reversed_domain}/{vpc_name}/{region}/route-tables/{route_table_name}]...
```

## Description

A rule that determines where network traffic from your subnet or gateway is directed.

Routing decisions are based on the most specific match.

## Properties

One of the following destination arguments must be supplied:

- **`destination_cidr_block`**

  The IPv4 CIDR address block used for the destination match.

- **`destination_ipv6_cidr_block`**

  The IPv6 CIDR block used for the destination match.

One of the following target arguments can be supplied:

- **`nat_gateway_name`**

  The name of the NAT gateway. Supports [Format String Syntax].

The default is the Internet Gateway attached to the VPC.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-routes.sh "{profile}" "{region}" "Name=route-table-id,Values={RouteTableId}"
```

### terraform.import()

```bash
terraform "-chdir=vpcs/{reversed_domain}/{vpc_name}/{region}/route-tables/{route_table_name}" import "-input=false" "aws_route.{route_id_}" "{RouteTableId}_{destination}"
```

## Events

### onchange

- **update**

  - [.route-table/internet-gateway]
  
    ```yaml
    when: nat_gateway_name is undefined
    ```

  - [.route-table/nat-gateway]

    ```yaml
    when: nat_gateway_name is defined
    ```

## See Also

- [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)
- [Terraform resource: `aws_route_table`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[.route-table/internet-gateway]: .route-table/internet-gateway.md
[.route-table/nat-gateway]: .route-table/nat-gateway.md
[Format String Syntax]: https://docs.python.org/3/library/string.html#format-string-syntax
[route-table]: route-table.md
[vpc]: vpc.md
