{{- define "agent-morpheus-models.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}

{{- end }}

{{- define "agent-morpheus-models.logic_check" -}}
{{- if and .Values.llama3_1_70b_instruct_4bit.enabled .Values.nim_llm.enabled }}
  hello: {{- required "Only one of models should be deployed!, either llama3_1_70b_instruct_4bit or nim-llm 8b, but not both!" .Values.whatever -}}
{{- end }}
{{- end }}



{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "agent-morpheus-models.fullname" -}}
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
{{- define "agent-morpheus-models.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "agent-morpheus-models.labels" -}}
helm.sh/chart: {{ include "agent-morpheus-models.chart" . }}
{{ include "agent-morpheus-models.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "agent-morpheus-models.selectorLabels" -}}
app.kubernetes.io/name: {{ include "agent-morpheus-models.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "agent-morpheus-models.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "agent-morpheus-models.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
