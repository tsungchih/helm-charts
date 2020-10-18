#!/bin/bash


VALUES_YAML=${1:-values.yaml}
K8S_NS=${2:-monitoring}
RELEASE_NAME=${3:-grafana}

helm upgrade --install \
    --namespace=${K8S_NS} \
    --values=${VALUES_YAML} \
    ${RELEASE_NAME} grafana/grafana
