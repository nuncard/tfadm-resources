// [.root] / [.aws] / [.region] / [vpc] /

# vpc-cidr-association

**Extends:** [.vpc/tags-all](.vpc/tags-all.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] vpc-cidr-association [{environment}/{region}/{cidr_block}]...
tfadm COMMAND [OPTIONS] vpc-cidr-association [{domain}/vpcs/{vpc_name}/{region}]...
```

## Description

Associates a secondary IPv4 CIDR block with the specified VPC.

## Properties

- **`cidr_block`**

  An IPv4 CIDR block to associate with the VPC. For example, `10.1.0.0/16`. You cannot specify an IPv4 CIDR block larger than `/16`.

- **`AssociationId`**

  The association ID for an IPv4 CIDR block associated with the VPC you want to sync with.

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-cidr-associations.sh "{profile}" "{region}" "Name=vpc-id,Values={VpcId}" "Name=is-default,Values=false" || \
.tfadm/bin/describe-cidr-associations.sh "{profile}" "{region}" "Name=cidr-block-association.association-id,Values={AssociationId}" "Name=is-default,Values=false" || \
.tfadm/bin/describe-cidr-associations.sh "{profile}" "{region}" "Name=cidr-block-association.cidr-block,Values={cidr_block}" "Name=is-default,Values=false" || \
.tfadm/bin/describe-cidr-associations.sh "{profile}" "{region}" "Name=dhcp-options-id,Values={DhcpOptionsId}" "Name=is-default,Values=false" || \
.tfadm/bin/describe-cidr-associations.sh "{profile}" "{region}" "Name=tag:Name,Values={vpc_name}" "Name=is-default,Values=false" || \
.tfadm/bin/describe-cidr-associations.sh "{profile}" "{region}" "Name=is-default,Values=false"
```

### sync.when() [^1]

```
vpc_name | default(None) is not none
```

### terraform.import()

```bash
terraform "-chdir={domain}/vpcs/{vpc_name}/{region}" import "-input=false" "aws_vpc_ipv4_cidr_block_association.{association_id_}" "{AssociationId}"
```

## See Also

- [Terraform resource: `aws_vpc_ipv4_cidr_block_association`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association)

[^1]: [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[vpc]: vpc.md
