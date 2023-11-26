// [.root] / [.aws] / [.region] / [vpc] /

# route-table

- **Extends:** [.vpc/tags-all](.vpc/tags-all.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] route-table [{environment}/{region}/{route_table_name}]...
tfadm COMMAND [OPTIONS] route-table [vpcs/{reversed_domain}/{vpc_name}/{region}/route-tables/{route_table_name}]...
```

## Description

A route table contains a set of rules, called routes.

## Properties

- **`route_table_name`**

  The name of the route table.

  *default: `main`*

- **`RouteTableId`**

  The ID of the route table you want to sync with.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-route-tables.sh "{profile}" "{region}" "Name=route-table-id,Values={RouteTableId}" || \
.tfadm/bin/describe-route-tables.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId} Name=tag:Name,Values={route_table_name}" || \
.tfadm/bin/describe-route-tables.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}"
```

### sync.when()

```
route_table_name | default(None) is not none
```

### terraform.import()

```bash
terraform "-chdir=vpcs/{reversed_domain}/{vpc_name}/{region}/route-tables/{route_table_name}" import "-input=false" "aws_route_table.this" "{RouteTableId}"
```

## Events

### oninit

- **create**

  - [.route-table/providers]
  - [.route-table/versions]
  - [.route-table/vpc]

## Children

- [.route-table/internet-gateway]
- [.route-table/nat-gateway]
- [.route-table/providers]
- [.route-table/versions]
- [.route-table/vpc]
- [route]

## See Also

- [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)
- [Terraform resource: `aws_route_table`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[.route-table/internet-gateway]: .route-table/internet-gateway.md
[.route-table/nat-gateway]: .route-table/nat-gateway.md
[.route-table/providers]: .route-table/providers.md
[.route-table/versions]: .route-table/versions.md
[.route-table/vpc]: .route-table/vpc.md
[route]: route.md
[vpc]: vpc.md
