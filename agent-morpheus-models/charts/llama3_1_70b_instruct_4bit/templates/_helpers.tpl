{{/*
Expand the name of the chart.
*/}}
{{- define "llama3_1_70b_instruct_4bit.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "llama3_1_70b_instruct_4bit.fullname" -}}
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
{{- define "llama3_1_70b_instruct_4bit.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "llama3_1_70b_instruct_4bit.labels" -}}
helm.sh/chart: {{ include "llama3_1_70b_instruct_4bit.chart" . }}
{{ include "llama3_1_70b_instruct_4bit.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: agent-morpheus
component: llama3.1-70b-instruct
inference: vllm
{{- end }}

{{/*
Selector labels
*/}}
{{- define "llama3_1_70b_instruct_4bit.selectorLabels" -}}
app.kubernetes.io/name: {{ include "llama3_1_70b_instruct_4bit.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

