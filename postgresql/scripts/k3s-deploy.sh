#!/usr/bin/env bash
set -euo pipefail


k3sup install --ip ${MASTER_IP} --context k3s-gce --local-path ~/.kube/config --merge --user ohughes

k3sup join --ip ${NODE1_IP} --server-ip ${MASTER_IP} --user ohughes
