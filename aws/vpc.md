# tfadm-resources-aws-vpc

A set of ready-for-use [tfadm](https://github.com/nuncard/tfadm) resources for generating and modifying [Terraform code](https://developer.hashicorp.com/terraform) to manage [Amazon Virtual Private Cloud (VPC)](https://aws.amazon.com/vpc/) services.

## In a Nutshell

Switch to the latest version of terraform (or use any other version older than `1.0`).

```bash
tfswitch -u
```

Generate the Terraform code for `dev` VPC (see [.vpc/default]).

```bash
# This should generate the same content as the `dhcp-options`, `prefix-lists`
# and `vpcs` directories in this repository.
tfadm create .vpc/default --overwrite dev/eu-west-1/10.0.0.0/16
```

Generate the Terraform code for `qa` and `prd` VPCs.

```bash
tfadm create .vpc/default qa/eu-west-1/10.4.0.0/16 prd/eu-west-1/10.8.0.0/16
```

Add `Test` tag to all objects that supports tags.

```bash
tfadm update .vpc/default - vpcs/com.example/*/* <<EOT
tags:
  Test: '123'
EOT
```

Convert the existing infrastructure to terraform code.

```bash
tfadm sync --recursive - <<EOF
environment: qa
region: eu-west-1
EOF
```

Add the `--import` flag to the previous command and also import existing infrastructure into the terraform state.

Use `cd PATH` to change to one of the created directories.

Initialize the working directory and generate a speculative execution plan, showing what actions terraform would take to apply the current configuration.

```bash
terraform init && terraform plan
```

Apart from adding some new tags, you should not be shown any other change.

## Resources

The `tfadm-resources-aws-vpc` set includes the following resources *(more to come in the future)*:

- [dhcp-options] `{environment}/{region}/{domain_name}`

  A set of DHCP options for your VPC.

- [prefix-list] `{environment}/{region}/{address_family}/{hostname}/{domain}/{cidr_block}`

  A managed prefix list is a set of one or more CIDR blocks. 

  - [prefix-list-entry] `{environment}/{region}/{address_family}/{hostname}/{domain}/{cidr_block}`

    An entry for a prefix list. 

- [vpc] `{environment}/{region}/{cidr_block}`

  A VPC is an isolated portion of the AWS Cloud.

  - [internet-gateway] `{environment}/{region}/{internet_gateway_name}`

    An internet gateway allows communication between your VPC and the internet.

  - [vpc-cidr-association] `{environment}/{region}/{cidr_block}`

    Associates a secondary IPv4 CIDR block with the specified VPC.

  - [vpc-dhcp-association] `{environment}/{region}/{dhcp_options_name}`

    Associates a set of DHCP options with the specified VPC.

  - [route-table] `{environment}/{region}/{route_table_name}`

    A route table contains a set of rules, called routes.

    - [route] `{environment}/{region}/{route_table_name}`
  
      A rule that determines where network traffic from your subnet or gateway is directed.

  - [security-group] `{environment}/{region}/{security_group_name}`

    A security group acts as a virtual firewall for your instances to control inbound and outbound traffic.

    - [security-group-rule] `{environment}/{region}/{security_group_name}/{type}/{ip_protocol}/{from_port}/{to_port}`

      Represents an inbound (ingress) or outbound (egress) rule for a security group.

  - [subnet] `{environment}/{region}/{az}/{subnet_name}/{cidr_block}`

    A subnet is a range of IP addresses in your VPC.

    - [nat-gateway] `{environment}/{region}/{az}/{subnet_name}/{nat_gateway_name}`

      Network Address Translation (NAT) service.

Use `tfadm resources RESOURCE` to check out the full configuration of a given resource.

## File Structure

The terraform code is generated following the file structure represented below.

```
.
├── dhcp-options
│   └── {reversed_domain}
│       └── {dhcp_options_name}
│           └── {region}
│               ├── dhcp-options.tf.json
│               ├── providers.tf.json
│               └── versions.tf.json
├── prefix-lists
│   └── {prefix_list_name}
│       └── {region}
│           ├── prefix-list.tf.json
│           ├── providers.tf.json
│           ├── variables.tf.json
│           └── versions.tf.json
└── vpcs
    └── {reversed_domain}
        └── {vpc_name}
            └── {region}
                ├── cidr-associations.tf.json
                ├── dhcp-association.tf.json
                ├── internet-gateway.tf.json
                ├── providers.tf.json
                ├── versions.tf.json
                ├── vpc.tf.json
                ├── route-tables
                │   └── {route_table_name}
                │       ├── internet-gateway.tf.json
                │       ├── nat-gateways.tf.json
                │       ├── providers.tf.json
                │       ├── route-table.tf.json
                │       ├── routes.tf.json
                │       ├── versions.tf.json
                │       └── vpc.tf.json
                ├── security-groups
                │   └── {security_group_name}
                │       ├── egress-rules.tf.json
                │       ├── group.tf.json
                │       ├── ingress-rules.tf.json
                │       ├── prefix-lists.tf.json
                │       ├── providers.tf.json
                │       ├── referenced-groups.tf.json
                │       ├── versions.tf.json
                │       └── vpc.tf.json
                └── subnets
                    └── {subnet_name}
                        ├── elastic-ips.tf.json
                        ├── nat-gateways.tf.json
                        ├── providers.tf.json
                        ├── subnets.tf.json
                        ├── versions.tf.json
                        └── vpc.tf.json
```

*(**TODO:** Generate also the `terragrunt.hcl.json` files for [terragrunt](https://terragrunt.gruntwork.io/), under the hood).*

[.vpc/default]: .tfadm/resources/.vpc/default.md
[dhcp-options]: .tfadm/resources/dhcp-options.md
[internet-gateway]: .tfadm/resources/internet-gateway.md
[nat-gateway]: .tfadm/resources/nat-gateway.md
[prefix-list-entry]: .tfadm/resources/prefix-list-entry.md
[prefix-list]: .tfadm/resources/prefix-list.md
[route-table]: .tfadm/resources/route-table.md
[route]: .tfadm/resources/roue.md
[security-group-rule]: .tfadm/resources/security-group-rule.md
[security-group]: .tfadm/resources/security-group.md
[subnet]: .tfadm/resources/subnet.md
[vpc-cidr-association]: .tfadm/resources/vpc-cidr-association.md
[vpc-dhcp-association]: .tfadm/resources/vpc-dhcp-association.md
[vpc]: .tfadm/resources/vpc.md
