# <img src=".github/logo.svg" width="56" alt="" /> OVH Snapshoter

Schedule snapshots of OpenStack Cinder volumes and clean up older snapshots after successful creation.

[![Continuous Integration](https://github.com/hoverkraft-tech/ovh-snapshoter/actions/workflows/main-ci.yml/badge.svg)](https://github.com/hoverkraft-tech/ovh-snapshoter/actions/workflows/main-ci.yml)
[![Release](https://img.shields.io/github/v/release/hoverkraft-tech/ovh-snapshoter)](https://github.com/hoverkraft-tech/ovh-snapshoter/releases)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)](docs/development/linting.md)

## Prerequisites

A Kubernetes cluster, a configured kubectl context and Helm with OCI registry support. Provide OpenStack credentials and the volume IDs to snapshot.

## Install

Review the [chart values](helm/chart/values.yaml), save your settings in `my-values.yaml`,
then install a published chart:

```sh
helm upgrade --install ovh-snapshoter oci://ghcr.io/hoverkraft-tech/charts/ovh-snapshoter \
  --namespace ovh-snapshoter --create-namespace \
  --values my-values.yaml
```

See [usage and configuration](docs/usage/installation.md) for more details.

## Contributing

Open an issue or pull request to discuss changes. The [contributor guide](docs/development/linting.md)
describes the dev container and local lint commands.

## Maintainer

Maintained by [Hoverkraft](https://hoverkraft.cloud).

## License

[Apache-2.0](LICENSE).
