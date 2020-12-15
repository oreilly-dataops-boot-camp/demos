#!/usr/bin/env bash
set -euo pipefail

k3sup install --ip $MASTER_IP --user ubuntu --context k3s
k3sup join --server-ip $MASTER_IP --ip $NODE1 --user ubuntu
k3sup join --server-ip $MASTER_IP --ip $NODE2 --user ubuntu
