#!/usr/bin/env bash
set -euo pipefail

kubectl config delete-context k3s-gce

kubectl config delete-cluster k3s-gce
