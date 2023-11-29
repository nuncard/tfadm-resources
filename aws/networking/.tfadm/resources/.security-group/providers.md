// [.root] / [.aws] / [.region] / [vpc] / [security-group] /

# .security-group/providers

- **Extends:** [.vpc/providers](../.vpc/providers.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] .security-group/providers [{environment}/{region}/{az}/{security_group_name}]...
tfadm COMMAND [OPTIONS] .security-group/providers [vpcs/{reversed_domain}/{vpc_name}/{region}/security-groups/{security_group_name}]...
```

[.aws]: ../../../../.tfadm/resources/README.md
[.region]: ../../../../.tfadm/resources/.region.md
[.root]: ../../../../../.tfadm/resources/README.md
[security-group]: ../security-group.md
[vpc]: ../vpc.md
