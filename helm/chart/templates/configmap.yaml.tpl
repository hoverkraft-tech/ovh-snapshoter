apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "chart.fullname" . }}
data:
  {{- with .Values.config }}
  CLEANUP: {{ .cleanup | default "false" | quote }}
  DRY_RUN: {{ .dryRun | default "false" | quote }}
  {{- end }}
