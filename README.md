# ovh volume snapshoter

[![Main - Continuous Integration](https://github.com/hoverkraft-tech/ovh-snapshoter/actions/workflows/main-ci.yml/badge.svg)](https://github.com/hoverkraft-tech/ovh-snapshoter/actions/workflows/main-ci.yml)
[![🚀 Release](https://github.com/hoverkraft-tech/ovh-snapshoter/actions/workflows/release.yml/badge.svg)](https://github.com/hoverkraft-tech/ovh-snapshoter/actions/workflows/release.yml)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/ovh-snapshoter)](https://artifacthub.io/packages/search?repo=ovh-snapshoter)

A easy way to take snapshots of any cinder cinder volumes from docker or kubernetes

Of course in kubernetes you can use CSI snapshot class to do the same but how to snapshot an external server for instance ?
This is why this project was created. enjoy.

## theory

- the main script is thought to run every day as a cronjob
- if the `DRY_RUN` var is true it will print what would have been done but will take no action
- if the `CLEANUP` var is true it will mark all pre-existing snapshots taken by the ovh-snapshoter (via metadata) before taking any other action
- if this succeed it will take a backup of all the volumes pointed by the `OS_VOLUMES` var
- finaly the script will clean all snapshots marked for cleanup

## install

```shell
helm upgrade ovh-snapshoter oci://ghcr.io/hoverkraft-tech/charts/ovh-snapshoter \
  --install --create-namespace --namespace ovh-snapshoter \
  --version 0.4.8 \
  --set config.osProjectId=xxxxxx --set config.osUsername=xxxxxx ....
```

The mandatory values are the following:

```yaml
config:
  osPassword: ""
  osProjectId: ""
  osRegionName: GRA11
  osTenantId: ""
  osTenantName: ""
  osUsername: ""
  osVolumes: []
```

You can get all of them (except `osVolumes`) by downloading an horizon config file from OVH UI
`osVolumes` is a list of volume ids that you want to backup on cronjob run (you can get them from OVH public cloud UI or horizon)

For full documentation check [here](./helm/chart/README.md)

## contributing

- Of course PRs and suggestions are welcome
- You can start a dev container with vscode and start working on it right away
