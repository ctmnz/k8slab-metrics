# k8slab-metrics

# Install docker, kind, kubectl, istioctl and helm

# Create the cluster
```bash
./create-cluster.sh
```
After few moments you will have locally installed:

- [Prometheus](http://prometheus.127.0.0.1.nip.io/)
- [Grafana](http://grafana.127.0.0.1.nip.io/)
- [Demo application](http://demoapp.127.0.0.1.nip.io)

# Cleanup/Delete the cluster
```bash
./delete-cluster.sh
```
