{{- if not .Values.deployment.enabled }}
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ include "chart.fullname" . }}
  namespace: {{ .Release.Namespace }}
spec:
  schedule: {{ .Values.cronjob.schedule }}
  jobTemplate:
    spec:
      template:
        spec:
          serviceAccountName: {{ include "chart.serviceAccountName" . }}
          automountServiceAccountToken: false
          {{- with .Values.imagePullSecrets }}
          imagePullSecrets:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.podSecurityContext | nindent 12 }}
          containers:
          - name: snapshoter
            image: "{{ .Values.image.registry }}/{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
            imagePullPolicy: {{ .Values.image.pullPolicy }}
            securityContext:
              {{- toYaml .Values.securityContext | nindent 14 }}
            resources:
              {{- toYaml .Values.resources | nindent 14 }}
            envFrom:
              - configMapRef:
                  name: {{ include "chart.fullname" . }}
              - secretRef:
                  name: {{ include "chart.fullname" . }}
          restartPolicy: OnFailure
{{- end }}
