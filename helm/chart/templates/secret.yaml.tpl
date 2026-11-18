apiVersion: v1
kind: Secret
metadata:
  name: {{ include "chart.fullname" . }}
type: Opaque
data:
  {{- with .Values.config }}
  OS_AUTH_URL: {{ .osAuthUrl | b64enc }}
  OS_IDENTITY_API_VERSION: {{ printf "%v" .osIdentityApiVersion | b64enc }}
  OS_PASSWORD: {{ .osPassword | default "password" | b64enc }}
  OS_PROJECT_DOMAIN_NAME: {{ .osProjectDomainName | b64enc }}
  OS_PROJECT_ID: {{ .osProjectId | b64enc }}
  OS_REGION_NAME: {{ .osRegionName | b64enc }}
  OS_TENANT_ID: {{ .osTenantId | b64enc }}
  OS_TENANT_NAME: {{ .osTenantName | b64enc }}
  OS_USER_DOMAIN_NAME: {{ .osUserDomainName | b64enc }}
  OS_USERNAME: {{ .osUsername | default "user" | b64enc }}
  OS_VOLUMES: {{ .osVolumes | join "," | b64enc }}
  {{- end }}
