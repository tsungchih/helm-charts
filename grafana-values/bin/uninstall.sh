#!/bin/bash


K8S_NS=${2:-monitoring}
RELEASE_NAME=${3:-grafana}

helm uninstall ${RELEASE_NAME} \
  --namespace=${K8S_NS}
