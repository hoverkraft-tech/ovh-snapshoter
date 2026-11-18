# <img src=".github/logo.svg" width="56" alt="" /> OVH Snapshoter

Schedule snapshots of OpenStack Cinder volumes and clean up older snapshots after successful creation.

[![Continuous Integration](https://github.com/hoverkraft-tech/ovh-snapshoter/actions/workflows/main-ci.yml/badge.svg)](https://github.com/hoverkraft-tech/ovh-snapshoter/actions/workflows/main-ci.yml)
[![Release](https://img.shields.io/github/v/release/hoverkraft-tech/ovh-snapshoter)](https://github.com/hoverkraft-tech/ovh-snapshoter/releases)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)](https://github.com/hoverkraft-tech/ovh-snapshoter/issues)

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

To install from source, run:

```sh
helm dependency build helm/chart
helm upgrade --install ovh-snapshoter ./helm/chart \
  --namespace ovh-snapshoter --create-namespace \
  --values my-values.yaml
```

Set OpenStack credentials and volume IDs under `config` in the values file.
The job creates snapshots, marks the snapshots it created, and removes older
snapshots after a successful creation. A failed creation stops cleanup.

## Development

Install Git, GNU Make, Docker with BuildKit, Helm, and kubectl.
Run `make lint`, `make lint-fix`, or `make lint '[.]github/'` from the repository
root. Open the repository in the dev container for the same tools and commands.

## Contributing

Open an issue or pull request to discuss changes.

## Maintainer

Maintained by [Hoverkraft](https://hoverkraft.cloud).

## License

[Apache-2.0](LICENSE).
