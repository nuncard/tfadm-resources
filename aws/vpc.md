# tfadm-resources-aws-vpc

A set of ready-for-use [tfadm](https://github.com/nuncard/tfadm) resources for generating and modifying [Terraform code](https://developer.hashicorp.com/terraform) to manage [Amazon Virtual Private Cloud (VPC)](https://aws.amazon.com/vpc/) services.

## In a Nutshell

Switch to the latest version of terraform (or use any other version older than `1.0`).

```bash
tfswitch -u
```

Generate the Terraform code for `dev` VPC.

```bash
# It should generate the same content as the example.com directory in this
# repository.
tfadm create .vpc/default --overwrite dev/eu-west-1/10.0.0.0/16
```

Generate the Terraform code for `qa` and `prd` VPCs.

```bash
tfadm create .vpc/default qa/eu-west-1/10.4.0.0/16 prd/eu-west-1/10.8.0.0/16
```

Add `Test` tag to all objects that supports tags.

```bash
tfadm update .vpc/default - example.com/vpcs/*/* <<EOT
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

- [dhcp-options](.tfadm/resources/dhcp-options.md) `{environment}/{region}/{domain_name}`

  A set of DHCP options for your VPC.

- [vpc](.tfadm/resources/vpc.md) `{environment}/{region}/{cidr_block}`

  A VPC is an isolated portion of the AWS Cloud.

  - [internet-gateway](.tfadm/resources/internet-gateway.md) `{environment}/{region}/{internet_gateway_name}`

    An internet gateway allows communication between your VPC and the internet.

  - [vpc-cidr-association](.tfadm/resources/vpc-cidr-association.md) `{environment}/{region}/{cidr_block}`

    Associates a secondary IPv4 CIDR block with the specified VPC.

  - [vpc-dhcp-association](.tfadm/resources/vpc-dhcp-association.md) `{environment}/{region}/{dhcp_options_name}`

    Associates a set of DHCP options with the specified VPC.

  - [subnet](.tfadm/resources/subnet.md) `{environment}/{region}/{az}/{subnet_name}/{cidr_block}`

    A subnet is a range of IP addresses in your VPC.

    - [nat-gateway](.tfadm/resources/nat-gateway.md) `{environment}/{region}/{az}/{subnet_name}/{nat_gateway_name}`

      Network Address Translation (NAT) service.

Use `tfadm resources RESOURCE` to check out the full configuration of a given resource.

## File Structure

The terraform code is generated following the file structure represented below.

```
.
└── {domain}
    ├── dhcp-options
    │   └── {dhcp_options_name}
    │       └── {region}
    │           ├── dhcp-options.tf.json
    │           ├── providers.tf.json
    │           └── versions.tf.json
    └── vpcs
        └── {vpc_name}
            └── {region}
                ├── dhcp-association.tf.json
                ├── internet-gateway.tf.json
                ├── providers.tf.json
                ├── subnets
                │   └── {subnet_name}
                │       ├── elastic-ips.tf.json
                │       ├── nat-gateways.tf.json
                │       ├── providers.tf.json
                │       ├── subnets.tf.json
                │       ├── versions.tf.json
                │       └── vpc.tf.json
                ├── versions.tf.json
                └── vpc.tf.json
```

*(**TODO:** Generate also the `terragrunt.hcl.json` files for [terragrunt](https://terragrunt.gruntwork.io/), under the hood).*
