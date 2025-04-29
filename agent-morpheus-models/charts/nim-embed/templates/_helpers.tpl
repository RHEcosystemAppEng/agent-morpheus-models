{{/*
Expand the name of the chart.
*/}}
{{- define "nim-embed.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nim-embed.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nim-embed.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nim-embed.labels" -}}
helm.sh/chart: {{ include "nim-embed.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: agent-morpheus
component: nim-embed
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nim-embed.selectorLabels" -}}
app: agent-morpheus
component: nim-embed
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nim-embed.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nim-embed.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

For inline NGC key, create image pull secret
*/}}
{{- define "nim-embed.generatedImagePullSecret" -}}
{{- if .Values.ngcSecret.apiKey }}
{{- printf "{\"auths\":{\"nvcr.io\":{\"username\":\"$oauthtoken\",\"password\":\"%s\"}}}" .Values.ngcSecret.apiKey | b64enc }}
{{- end }}
{{- end }}