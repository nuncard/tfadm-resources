# tfadm-resources

A set of ready-for-use resource samples to help you get started with [Terraform Administrator (TfAdm)](https://github.com/nuncard/tfadm).

## Requirements

Before moving on to the [Getting Started](#getting-started) section, make sure you have the following tools installed on your computer:

- [bash](https://www.gnu.org/software/bash/), to execute the instructions in this documentation;
- [tfadm](https://github.com/nuncard/tfadm), to compile and use the resources provided by this project and generate and modify terraform code;
- [tfswitch](https://github.com/warrensbox/terraform-switcher), to download and install the latest version of [Terraform](https://developer.hashicorp.com/terraform/downloads);
- [yq](https://github.com/mikefarah/yq), to adjust the TfAdm resource configuration to suit your use case;

## Getting Started

The root module of this TfAdm project is called `tfadm-resources-core` and includes only internal resources.

The `.root` resource is the root of the hierarchical resource tree. Any inheritable properties added to this resource will be available across all resources in this project.

Get started by setting the variable below to suit your use case, and execute the instruction in your Bash console.

```bash
# Root domain name that you use to globally identify your services on the Internet.
# Avoid use here country specif root domain names.
# You can later re-write this value on country specific configuration resources.
root_domain='example.com'
```

Having the `root_domain` variable set, execute the next instruction to update the configuration.

```bash
yq ".properties.domain.value = \"$root_domain\"" -i .tfadm/resources/.root.yml
```

Then follow the documentation for each of the supported [Terraform Providers](https://registry.terraform.io/browse/providers):

  - [Amazon Web Services (AWS)](aws/README.md);
  - *(More to come in the future).*

## Reference

TfAdm resources are basically a set of configuration files, in [YAML format](https://yaml.org/). Each file represents an object, such as a class in [Object Oriented Programming (OOP)](https://en.wikipedia.org/wiki/Object-oriented_programming) languages. Thus, a TfAdm resource is a template for an object, and the generated data is an instance of a TfAdm resource. In other words, a TfAdm resource dynamically replicates a predefined data structure with values specified from stdin. The result is then stored in a file, like a row in a database table. Therefore, we can later modify each of these [Terraform](https://developer.hashicorp.com/terraform) objects using its `primary_key`. A file, name of which begins with the `.` character, represents an internal resource, such as an abstract class in OOP.

[Inheritance](https://www.w3schools.com/java/java_inheritance.asp) plays a big role in the way TfAdm resources are structured. Helps avoiding redundancy by allowing a resource to extend other resources. To inherit from a TfAdm resource, use the `extends` configuration property. Additionally, you can use the `parent` configuration property on a child resource to inherit all properties that are explicitly marked as inheritable on parent resources. Thus, when compiled by TfAdm, resources are structured into a hierarchical tree.

So, by combining the `extends` and `parent` configuration properties, we can reuse a TfAdm resource to generate virtually the same data in different file system paths.

A directory containing a `.tfadm/resources` directory is considered a TfAdm project or module, allowing TfAdm to operate on that directory, and specifies the root folder where will be stored the objects generated by the TfAdm resources found in the `.tfadm/resources` directory. A sub-directory of a directory containing a `.tfadm/resources` directory is considered a TfAdm sub-module. Thus, a resource in a sub-module can be a child of a resource in any of the modules found in the parent directories (parent modules), as well as extend other resources of the parent modules. The module at the top of the hierarchical module tree is considered a root module.

Therefore, a module's TfAdm resource files go in that module's `.tfadm/resources` directory. The file name of a TfAdm resource must end with the suffix `.yml` or `.yaml`.

As for the [encapsulation](https://www.w3schools.com/java/java_encapsulation.asp) OOP concept, avoid it as much as possible. Get rid of all Terraform modules where the [Terraform language](https://developer.hashicorp.com/terraform/language) is being used as an [imperative programming](https://en.wikipedia.org/wiki/Imperative_programming) language, to encapsulate and reuse parts of Terraform code. We want TfAdm resources to be as flexible as possible, be easy to modify and maintain. So, keep it simple and straightforward. Use Terraform as a [declarative programming](https://en.wikipedia.org/wiki/Declarative_programming) language and take advantage of the imperative part of Terraform programming language only when strictly necessary. The result should be a very readable Terraform code that reflects exactly what we want to see: a clear representation of the infrastructure configuration.

*(**TODO:** Add a brief description of each of the configuration properties).*

## See Also

- [Jinja expressions](https://jinja.palletsprojects.com/en/3.1.x/templates/#expressions)
- [Terraform Language](https://developer.hashicorp.com/terraform/language)
