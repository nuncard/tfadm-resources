# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Calendar Versioning](https://calver.org/).

## [Unreleased]

### Added

- Added resources for managing AWS Route Tables;
- NAT gateway: `private_ip` now supports [Format String Syntax].

### Changed

- Rewritten `.filter/dynamic` resource to be functional;
- Changed `nat_gateway_name` default value to `nat.{az}`;
- NAT gateway: `private_ip` now has no default value.

### Fixed

- Minor bugs fixed and some refactorings.

## [2023.09.19]

### Added

- Added `CHANGELOG.md`;
- Documented all remaining undocumented resources.

### Changed

- Moved resource's reference documentation into `.tfadm/resources` directory;
- `aws/vpc-resources.md` renamed to `aws/vpc.md`;
- `aws/aws.md` renamed to `aws/.tfadm/resources/README.md`;
- `root.md` renamed to `.tfadm/resources/README.md`;
- Improved documentation.

## [2023.09.17]

### Added

- First release.

[unreleased]: https://github.com/nuncard/tfadm-resources/compare/2023.09.19...HEAD
[2023.09.19]: https://github.com/nuncard/tfadm-resources/compare/2023.09.17...2023.09.19
[2023.09.17]: https://github.com/nuncard/tfadm-resources/releases/tag/2023.09.17
[Format String Syntax]: https://docs.python.org/3/library/string.html#format-string-syntax
