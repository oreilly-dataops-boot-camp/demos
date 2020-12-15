multipass launch -n k3s-master -c 2 -m 4g --cloud-init cloud-init.yaml
multipass launch -n k3s-node1 -c 2 -m 4g --cloud-init cloud-init.yaml
multipass launch -n k3s-node2 -c 2 -m 4g --cloud-init cloud-init.yaml
