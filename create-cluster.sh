#!/bin/bash

kind create cluster --config=./home-cluster.yaml

### Installing the needed stuff

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

kubectl create namespace istio-system

## Installing old 1.18.0-rc.0 istio version 
helm install istio-base istio/base -n istio-system --version 1.18.0-rc.0 --set defaultRevision=default
helm install istiod istio/istiod -n istio-system  --version 1.18.0-rc.0
helm upgrade -i istio-ingressgateway istio/gateway -n istio-system --version 1.18.0-rc.0 --values ./istio-ingress-patch.yaml  --wait
helm upgrade -i istio-egressgateway istio/gateway -n istio-system --version 1.18.0-rc.0 --values ./istio-egress-patch.yaml  --wait

## Installing the latest version of istio
helm install istiod-1-19-3 istio/istiod --version 1.19.3 --set revision=1-19-3 -n istio-system
helm install istio-ingressgateway-1-19-3 istio/gateway --version 1.19.3 --set revision=1-19-3 -n istio-system
helm install istio-egressgateway-1-19-3 istio/gateway --version 1.19.3 --set revision=1-19-3 -n istio-system
# helm install istio-base istio/base -n istio-system --version 1.19.3 --set defaultRevision=default


# Installing Prometheus http://prometheus.127.0.0.1.nip.io
kubectl apply -f ./prometheus.yaml

# Installing Grafana http://grafana.127.0.0.1.nip.io
kubectl apply -f ./grafana.yaml

# Installing the argocd rollouts demo app
kubectl apply -f ./demoapp.yaml

