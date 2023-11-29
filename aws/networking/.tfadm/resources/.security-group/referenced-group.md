// [.root] / [.aws] / [.region] / [vpc] / [security-group] /

# .security-group/referenced-group

- **Extends:** [.filter/tags](../../../../.tfadm/resources/.filter/tags.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] .security-group/referenced-group [{environment}/{region}/{security_group_name}]...
tfadm COMMAND [OPTIONS] .security-group/referenced-group [vpcs/{reversed_domain}/{vpc_name}/{region}/security-groups/{security_group_name}]...
```

## Description

Provides details about a specific security group.

## Properties

- **`referenced_security_group_name`**

  The name of the security group that is referenced in the security group rule.

  *use: `tags/Name`*

- **`ReferencedSecurityGroupName`**

  *use: `name`*

  *when: `referenced_security_group_name is undefined or referenced_security_group_name == "default"`*

## See Also

- [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)
- [Terraform data source `aws_security_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group)

[.aws]: ../../../../.tfadm/resources/README.md
[.region]: ../../../../.tfadm/resources/.region.md
[.root]: ../../../../../.tfadm/resources/README.md
[security-group]: ../security-group.md
[vpc]: ../vpc.md
