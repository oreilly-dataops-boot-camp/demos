

gcloud config set compute/zone europe-west2-a
gcloud config set compute/region europe-west2
gcloud compute config-ssh

gcloud \
  compute \
  firewall-rules \
  create \
  k3s \
  --allow=tcp:6443 \
  --target-tags=k3s

gcloud \
  compute \
  instances \
  create \
  k3s-single-node \
  --machine-type=n2-standard-2 \
  --tags k3s

gcloud compute instances describe k3s-single-node \
     --format='value(networkInterfaces.accessConfigs[0].natIP)'

export EXTERNAL_IP=$(gcloud compute instances describe k3s-single-node \
     --format='value(networkInterfaces.accessConfigs[0].natIP)')

k3sup install --ip "${EXTERNAL_IP}" --ssh-key ~/.ssh/google_compute_engine --user "$(whoami)"
