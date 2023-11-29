// [.root] / [.aws] / [.region] / [vpc] / [subnet] /

# .subnet/elastic-ip

- **Extends:** [.elastic-ip], [.subnet/tags-all]

## Synopsis

```
tfadm COMMAND [OPTIONS] .subnet/elastic-ip [{environment}/{region}/{az}/{subnet_name}]...
tfadm COMMAND [OPTIONS] .subnet/elastic-ip [vpcs/{reversed_domain}/{vpc_name}/{region}/subnets/{subnet_name}]...
```

## Properties

- **`allocation_name`**

  *default: `{subnet_name}`*

## Methods

### terraform.import()

```bash
terraform "-chdir=vpcs/{reversed_domain}/{vpc_name}/{region}/subnets/{subnet_name}" import "-input=false" "aws_eip.{allocation_id_}" "{AllocationId}"
```

## Children

- [nat-gateway](../nat-gateway.md)

[.aws]: ../../../../.tfadm/resources/README.md
[.elastic-ip]: ../../../../.tfadm/resources/.elastic-ip.md
[.region]: ../../../../.tfadm/resources/.region.md
[.root]: ../../../../../.tfadm/resources/README.md
[.subnet/tags-all]: ../.subnet/tags-all.md
[nat-gateway]: ../nat-gateway.md
[subnet]: ../subnet.md
[vpc]: ../vpc.md
