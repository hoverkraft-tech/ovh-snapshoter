# ovh-snapshoter

![Version: 0.4.10](https://img.shields.io/badge/Version-0.4.10-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.4.10](https://img.shields.io/badge/AppVersion-0.4.10-informational?style=flat-square)

A Helm chart for ovh-snapshoter

**Homepage:** <https://github.com/hoverkraft-tech/ovh-snapshoter>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Frederic Leger | <frederic@webofmars.com> |  |
| Emilien Escalle | <emilien.escalle@escemi.com> |  |

## Source Code

* <https://github.com/hoverkraft-tech/ovh-snapshoter>
* <https://raw.githubusercontent.com/hoverkraft-tech/ovh-snapshoter/refs/heads/main/helm/chart/values.yaml>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| config.cleanup | string | `"true"` |  |
| config.dryRun | string | `"false"` |  |
| config.osAuthUrl | string | `"https://auth.cloud.ovh.net/v3"` |  |
| config.osIdentityApiVersion | int | `3` |  |
| config.osPassword | string | `""` |  |
| config.osProjectDomainName | string | `"Default"` |  |
| config.osProjectId | string | `""` |  |
| config.osRegionName | string | `"GRA11"` |  |
| config.osTenantId | string | `""` |  |
| config.osTenantName | string | `""` |  |
| config.osUserDomainName | string | `"Default"` |  |
| config.osUsername | string | `""` |  |
| config.osVolumes | list | `[]` |  |
| cronjob.schedule | string | `"0 0 * * *"` |  |
| deployment.enabled | bool | `false` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"hoverkraft-tech/ovh-snapshoter/app"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
