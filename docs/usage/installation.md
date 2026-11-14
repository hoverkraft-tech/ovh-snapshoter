# Installation and configuration

## Published charts

The chart is published at `oci://ghcr.io/hoverkraft-tech/charts/ovh-snapshoter`.
Choose a version from the [releases](https://github.com/hoverkraft-tech/ovh-snapshoter/releases)
and add `--version <chart-version>` when you need a reproducible deployment.

The [chart reference](../../helm/chart/README.md) and
[values file](../../helm/chart/values.yaml) describe the supported configuration.
Keep secrets outside Git and protect any local values file containing credentials.

## Install from source

From the repository root:

```sh
helm dependency build helm/chart
helm upgrade --install ovh-snapshoter ./helm/chart \
  --namespace ovh-snapshoter --create-namespace \
  --values my-values.yaml
```

## Snapshot behavior

Set `config.osProjectId`, `config.osUsername`, `config.osPassword`,
`config.osTenantId`, `config.osTenantName`, `config.osRegionName` and
`config.osVolumes` from your OVH OpenStack configuration.
`config.osVolumes` is the list of volume IDs to snapshot.

With cleanup enabled, the job marks snapshots it previously created, creates new
snapshots, then removes marked snapshots. A failed creation stops the script
before cleanup. Dry-run mode prints the intended operations without modifying
volumes or snapshots.
