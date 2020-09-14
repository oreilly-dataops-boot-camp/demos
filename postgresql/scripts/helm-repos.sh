#!/usr/bin/env bash
set -euo pipefail

helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add postgres-operator https://raw.githubusercontent.com/zalando/postgres-operator/master/charts/postgres-operator
helm repo add postgres-operator-ui https://raw.githubusercontent.com/zalando/postgres-operator/master/charts/postgres-operator-ui
