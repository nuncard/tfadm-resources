// [.root] / [.aws] / [.region] / [vpc] / [subnet] /

# .subnet/elastic-ip

**Extends:** [.elastic-ip], [.subnet/tags-all]

## Synopsis

```
tfadm COMMAND [OPTIONS] .subnet/elastic-ip [{environment}/{region}/{az}/{subnet_name}]...
tfadm COMMAND [OPTIONS] .subnet/elastic-ip [{domain}/vpcs/{vpc_name}/{region}/subnets/{subnet_name}]...
```

## Properties

- **`allocation_name`**

  *default: `{subnet_name}`*

## Methods

### terraform.import()

```bash
terraform "-chdir={domain}/vpcs/{vpc_name}/{region}/subnets/{subnet_name}" import "-input=false" "aws_eip.{allocation_id_}" "{AllocationId}"
```

## Children

- [nat-gateway](../nat-gateway.md)

## See Also

- [Terraform resource: `aws_nat_gateway`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)

[^1]: [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)

[.aws]: ../README.md
[.elastic-ip]: ../.elastic-ip.md
[.region]: ../.region.md
[.root]: ../../../../.tfadm/resources/README.md
[.subnet/tags-all]: ../.subnet/tags-all.md
[nat-gateway]: ../nat-gateway.md
[subnet]: ../subnet.md
[vpc]: ../vpc.md
