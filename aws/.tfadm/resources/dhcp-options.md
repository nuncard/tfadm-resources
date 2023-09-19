// [.root] / [.aws] / [.region] /

# dhcp-options

- **Extends:** [.tags-all]

## Synopsis

```
tfadm COMMAND [OPTIONS] dhcp-options [{environment}/{region}/{domain_name}]...
tfadm COMMAND [OPTIONS] dhcp-options [{domain}/dhcp-options/{dhcp_options_name}/{region}]...
```

## Description

Dynamic Host Configuration Protocol (DHCP) provides a standard for passing configuration information to hosts on a TCP/IP network. You can create as many additional DHCP option sets as you want. However, you can only associate a VPC with one set of DHCP option at a time. After you create a set of DHCP option, you must configure your VPC to use it.

## Properties

- **`dhcp_options_name`**

  DHCP option set name.

  *default: `{environment}`*

- **`DhcpOptionsId`**

  The ID of the DHCP option set you want to sync with.

- **`domain_name`**

  This value is used to complete unqualified DNS hostnames. Some Linux operating systems accept multiple domain names separated by spaces. However, Windows and other Linux operating systems treat the value as a single domain, which results in unexpected behavior. If your DHCP options set is associated with a VPC that has instances with multiple operating systems, specify only one domain name.

  *default: `{region}.{dhcp_options_name}.{domain}`*

- **`domain_name_servers`**

  The IP addresses of up to four domain name servers, or `AmazonProvidedDNS`.

  *default: `AmazonProvidedDNS`*

- **`ntp_servers`**

  The IP addresses of up to four Network Time Protocol (NTP) servers.

  *default: `169.254.169.123`*

- **`netbios_name_servers`**

  The IP addresses of up to four NetBIOS name servers.

- **`netbios_node_type`**

  The NetBIOS node type (`1`, `2`, `4`, or `8`). We recommend that you specify `2` (broadcast and multicast are not currently supported). For more information about these node types, see [RFC 2132](http://www.ietf.org/rfc/rfc2132.txt).

## Methods

### sync.describe()

```bash
.tfadm/bin/describe-dhcp-options.sh "{profile}" "{region}" "Name=dhcp-options-id,Values={DhcpOptionsId}" || \
.tfadm/bin/describe-dhcp-options.sh "{profile}" "{region}" "Name=tag:Name,Values={dhcp_options_name}" || \
.tfadm/bin/describe-dhcp-options.sh "{profile}" "{region}"
```

### sync.when() [^1]

```
dhcp_options_name | default(None, true) is not none
```

### terraform.import()

```bash
terraform "-chdir={domain}/dhcp-options/{dhcp_options_name}/{region}" import "-input=false" "aws_vpc_dhcp_options.this" "{DhcpOptionsId}"
```

## Events

### oninit

- **create**

  - [.dhcp-options/providers]
  - [.dhcp-options/versions]

## Children

- [.dhcp-options/providers]
- [.dhcp-options/versions]

## See Also

- [Terraform resource: `aws_vpc_dhcp_options`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options)

[^1]: [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)

[.aws]: README.md
[.region]: .region.md
[.root]: ../../../.tfadm/resources/README.md
[.tags-all]: .tags-all.md
[.dhcp-options/providers]: .dhcp-options/providers.md
[.dhcp-options/versions]: .dhcp-options/versions.md
