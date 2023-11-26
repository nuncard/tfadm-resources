# tfadm-resources-aws

A set of ready-for-use [tfadm](https://github.com/nuncard/tfadm) resources for generating and modifying [terraform code](https://developer.hashicorp.com/terraform) to manage AWS services.

## Dependencies

- [tfadm-resources-code](../README.md)

## Requirements

- [AWS Command Line Interface (AWS CLI)](https://aws.amazon.com/cli/), to convert existing infrastructure into Terraform code;
- [jq](https://jqlang.github.io/jq/download/), used in the bash scripts, included in the `.tfadm/bin` directory, to process the data return by AWS CLI.

## Getting Started

The `.aws` resource is the root of the hierarchical resource tree of the `tfadm-resources-aws` module. Any inheritable properties added to this resource will be available across all resources in this module.

Get started by setting the variable below to suit your use case, and execute the instruction in your Bash console.

```bash
# Use a specific profile from your credential file.
profile='"default"'
# Amazon Resource Name (ARN) of the IAM Role to assume.
assume_role_arn='null'
# The name of the tag to which the value of the domain property inherited from
# the tfadm-resources-core module should be assigned.
tags_domain='Domain'
# Set to true if objects in your existing infrastructure do not have the
# domain tag, and you intend to run the terraform plan over the generated code
# without needing to apply anything to resolve terraform resource dependencies.
filter_domain_ignore='null'
# The name of the tag to which the value of the environment property inherited
# from the tfadm-resources-core module should be assigned.
tags_environment='Environment'
# The name of the tag to which the value of the region property should be
# assigned.
tags_region='Region'
# The name of the tag to which the value of the availability_zone property
# should be assigned.
tags_availability_zone='AvailabilityZone'
# The name of the tag to which the value of the managed_by property should be
# assigned.
tags_managed_by='ManagedBy'
# The value of the managed_by property
tags_managed_by_value='"terraform"'
# The name of the existing subnet you want to convert to terraform code by
# default. Wildcard patterns are supported. To specify multiple names, use a
# list in JSON format, e.g, ["dmz-1","dmx-2"]. Just to avoid generating the code
# for everything by default. You can still convert everything using the --force
# option of the tfadm sync command.
dmz_subnet_name='"dmz"'
# The name of the security group you want to convert to terraform code by
# default.
default_security_group_name='"default"'
```

Having the previous variables set, execute the next instructions to update the configuration.

```bash
yq ".properties.profile.value = $profile" -i .tfadm/resources/.aws.yml && \
yq ".properties.assume_role_arn.value = $assume_role_arn" -i .tfadm/resources/.aws.yml && \
yq ".properties.domain.ignore = $filter_domain_ignore" -i .tfadm/resources/.filter/tags.yml && \
yq ".methods.sync.when.security_group_name = $default_security_group_name" -i .tfadm/resources/security-group.yml && \
yq ".methods.sync.when.subnet_name = $dmz_subnet_name" -i .tfadm/resources/subnet.yml && \
yq ".properties.domain.sync = \"Tags/$tags_domain\"" -i .tfadm/resources/.tags-all.yml && \
yq ".properties.aws.properties.default_tags.properties.domain.use = (\"$tags_domain\" | select(. != \"domain\") // null)" -i .tfadm/resources/.providers.yml && \
yq ".properties.domain.use = \"dynamic/filter/for_each/tag:$tags_domain\"" -i .tfadm/resources/.filter/dynamic.yml && \
yq ".properties.domain.use = \"tags/$tags_domain\"" -i .tfadm/resources/.filter/tags.yml && \
yq ".properties.environment.sync = \"Tags/$tags_environment\"" -i .tfadm/resources/.tags-all.yml && \
yq ".properties.aws.properties.default_tags.properties.environment.use = (\"$tags_environment\" | select(. != \"environment\") // null)" -i .tfadm/resources/.providers.yml && \
yq ".properties.environment.use = \"dynamic/filter/for_each/tag:$tags_environment\"" -i .tfadm/resources/.filter/dynamic.yml && \
yq ".properties.environment.use = \"tags/$tags_environment\"" -i .tfadm/resources/.filter/tags.yml && \
yq ".properties.aws.properties.default_tags.properties.region.use = (\"$tags_region\" | select(. != \"region\") // null)" -i .tfadm/resources/.providers.yml && \
yq ".properties.availability_zone |= . + {\"sync\": \"Tags/$tags_availability_zone\", \"use\": \"tags/$tags_availability_zone\"}" -i .tfadm/resources/.subnet/tags-all.yml && \
yq ".properties.aws.properties.default_tags.properties.managed_by |= . + {\"use\": (\"$tags_managed_by\" | select(. != \"managed_by\") // null), \"value\": $tags_managed_by_value}" -i .tfadm/resources/.providers.yml && \
yq ".properties.tags.unset = ([\"$tags_environment\", \"$tags_domain\", \"$tags_managed_by\", \"$tags_region\"] | sort)" -i .tfadm/resources/.tags-all.yml
```

Then, follow the documentation for the following AWS services:

- [Virtual Private Cloud (VPC)](vpc.md);
-  *(More to come in the future).*
