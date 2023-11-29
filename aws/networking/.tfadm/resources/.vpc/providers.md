// [.root] / [.aws] / [.region] / [vpc] /

# .vpc/providers

- **Extends:** [.providers](../../../../.tfadm/resources/.providers.md)

## Synopsis

```
tfadm COMMAND [OPTIONS] .vpc/providers [{environment}/{region}]...
tfadm COMMAND [OPTIONS] .vpc/providers [{domain}/vpc/{vpc_name}/{region}]...
```

## Direct Sub-resources

- [.route-table/providers](../.route-table/providers.md)
- [.security-group/providers](../.security-group/providers.md)
- [.subnet/providers](../.subnet/providers.md)

[.aws]: ../../../../.tfadm/resources/README.md
[.region]: ../../../../.tfadm/resources/.region.md
[.root]: ../../../../../.tfadm/resources/README.md
[vpc]: ../vpc.md
