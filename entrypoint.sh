#!/bin/sh -l

set -e
set -o pipefail

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

bash -c "set -e;  set -o pipefail; $1"
