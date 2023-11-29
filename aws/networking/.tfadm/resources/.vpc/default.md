// [.root] / [.aws] / [.region] /

# .vpc/default

- **Extends:** [vpc](../vpc.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] .vpc/default [{environment}/{region}/{cidr_block}]...
tfadm COMMAND [OPTIONS] .vpc/default [{domain}/vpc/{vpc_name}/{region}]...
```

## Properties

- **`dhcp_options_name`**
  
  DHCP option set name.

  *value: `{vpc_name}`*

- **`internet_gateway_name`**

  The name of the Internet Gateway.

  *value: `{vpc_name}`*

- **`subnet_name`**

  The name of the subnet.

  *value: `dmz`*

## Events

### onchange

- **update**

  - [dhcp-options]

  - [prefix-list]

    ```yaml
    address_family: IPv4
    hostname: '{region}.{vpc_name}'
    ```

  - [internet-gateway]

  - [vpc-dhcp-association]

  - [vpc-cidr-association]

    ```yaml
    cidr_block: '${cidrsubnet([for parts in [split("/", aws_vpc.this.cidr_block)]: join("/", [parts[0], parts[1] - 2])][0], 2, 1)}'
    ```

  - [vpc-cidr-association]

    ```yaml
    cidr_block: '${cidrsubnet([for parts in [split("/", aws_vpc.this.cidr_block)]: join("/", [parts[0], parts[1] - 2])][0], 2, 2)}'
    ```

  - [security-group]

    ```yaml
    security_group_name: default
    ```

  - [security-group]

    ```yaml
    security_group_name: ingress
    ```

  - [security-group-rule]

    ```yaml
    ip_protocol: icmp
    security_group_name: default
    type: in
    ```

  - [security-group-rule]

    ```yaml
    cidr_ipv4: 0.0.0.0/0
    ip_protocol: all
    security_group_name: ingress
    type: out
    ```

  - [security-group-rule]

    ```yaml
    cidr_ipv4: 0.0.0.0/0
    from_port: 80
    ip_protocol: tcp
    security_group_name: ingress
    type: in
    ```

  - [security-group-rule]

    ```yaml
    cidr_ipv4: 0.0.0.0/0
    from_port: 443
    ip_protocol: tcp
    security_group_name: ingress
    type: in
    ```

  - [subnet]

    ```yaml
    az: a
    cidr_block: '${cidrsubnet(data.aws_vpc.this.cidr_block, 8, 0)}'
    ```

  - [subnet]

    ```yaml
    az: b
    cidr_block: '${cidrsubnet(data.aws_vpc.this.cidr_block, 8, 1)}'
    ```

  - [subnet]

    ```yaml
    az: c
    cidr_block: '${cidrsubnet(data.aws_vpc.this.cidr_block, 8, 2)}'
    ```

  - [nat-gateway]

    ```yaml
    az: a
    nat_gateway_name: nat.a
    private_ip: '${{cidrhost(aws_subnet.{subnet_id_}.cidr_block, -2)}}'
    ```

  - [nat-gateway]

    ```yaml
    az: b
    nat_gateway_name: nat.b
    private_ip: '${{cidrhost(aws_subnet.{subnet_id_}.cidr_block, -2)}}'
    ```

  - [nat-gateway]

    ```yaml
    az: c
    nat_gateway_name: nat.c
    private_ip: '${{cidrhost(aws_subnet.{subnet_id_}.cidr_block, -2)}}'
    ```

  - [route-table]

    ```yaml
    route_table_name: main
    ```

  - [route-table]

    ```yaml
    route_table_name: a
    ```

  - [route-table]

    ```yaml
    route_table_name: b
    ```

  - [route-table]

    ```yaml
    route_table_name: c
    ```

  - [route]

    ```yaml
    destination_cidr_block: 0.0.0.0/0
    route_table_name: main
    ```

  - [route]

    ```yaml
    destination_cidr_block: 0.0.0.0/0
    nat_gateway_name: nat.a
    route_table_name: a
    ```

  - [route]

    ```yaml
    destination_cidr_block: 0.0.0.0/0
    nat_gateway_name: nat.b
    route_table_name: b
    ```

  - [route]

    ```yaml
    destination_cidr_block: 0.0.0.0/0
    nat_gateway_name: nat.c
    route_table_name: c
    ```

[.aws]: ../../../../.tfadm/resources/README.md
[.region]: ../../../../.tfadm/resources/.region.md
[.root]: ../../../../../.tfadm/resources/README.md
[dhcp-options]: ../dhcp-options.md
[internet-gateway]: ../internet-gateway.md
[nat-gateway]: ../nat-gateway.md
[prefix-list]: ../prefix-list.md
[route-table]: ../route-table.md
[route]: ../route.md
[security-group-rule]: ../security-group-rule.md
[security-group]: ../security-group.md
[subnet]: ../subnet.md
[vpc-cidr-association]: ../vpc-cidr-association.md
[vpc-dhcp-association]: ../vpc-dhcp-association.md
[vpc]: ../vpc.md
