# tfadm-resources-aws-vpc

A set of ready-for-use [tfadm](https://github.com/nuncard/tfadm) resources for generating and modifying [terraform code](https://developer.hashicorp.com/terraform) to manage Amazon VPC services.

[Amazon Virtual Private Cloud (Amazon VPC)](https://aws.amazon.com/vpc/) gives you full control over your virtual networking environment, including resource placement, connectivity, and security.

## In a Nutshell

Switch to the latest version of terraform (or use any other version older than `1.0`).

```bash
tfswitch -u
```

Generate the terraform code to manage Amazon VPC services.

```bash
# It should generate the same content as the example.com directory in this
# repository.
tfadm create .vpc/default --overwrite dev/eu-west-1/10.0.0.0/16
```

Or convert the existing infrastructure to terraform code.

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

- [dhcp-options](./dhcp-options.md) `{environment}/{region}/{domain_name}`

  A set of DHCP options for your VPC.

- [vpc](./vpc.md) `{environment}/{region}/{cidr_block}`

  A VPC is an isolated portion of the AWS Cloud.

  - [internet-gateway](./internet-gateway.md) `{environment}/{region}/{internet_gateway_name}`

    An internet gateway allows communication between your VPC and the internet.

  - [vpc-cidr-association](./vpc-cidr-association.md) `{environment}/{region}/{cidr_block}`

    Associates a secondary IPv4 CIDR block with the specified VPC.

  - [vpc-dhcp-association](./vpc-dhcp-association.md) `{environment}/{region}/{dhcp_options_name}`

    Associates a set of DHCP options with the specified VPC.

  - [subnet](./subnet.md) `{environment}/{region}/{az}/{subnet_name}/{cidr_block}`

    A subnet is a range of IP addresses in your VPC.

    - [nat-gateway](./nat-gateway.md) `{environment}/{region}/{az}/{subnet_name}/{nat_gateway_name}`

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
