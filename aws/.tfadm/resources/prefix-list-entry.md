// [.root] / [.aws] / [.region] / [prefix-list] /

# prefix-list-entry

## Synopsis

```
tfadm COMMAND [OPTIONS] prefix-list-entry [{environment}/{region}/{address_family}/{hostname}/{domain}/{cidr_block}]...
tfadm COMMAND [OPTIONS] prefix-list-entry [prefix-lists/{prefix_list_name}/{region}]...
```

## Description

An entry for a prefix list.

## Properties

- **`cidr_block`**
  
  The CIDR block.

  *use: `cidr`*

- **`description`**
  
  A description for the entry, up to 255 characters in length.

## Methods

### sync.describe()

```bash
aws ec2 get-managed-prefix-list-entries --profile "{profile}" --region "{region}" --prefix-list-id "{PrefixListId}" --query "Entries" --no-paginate --output json
```

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[prefix-list]: prefix-list.md
