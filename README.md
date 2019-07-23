### Kubernetes Guestbook NGINX + GCP Example
---
#### - Build K8x Cluster

```
bash kubernetes/k8s-cluster.sh build
```

#### - Deploy Guestbook Application

```
bash kubernetes/guestbook-app.sh build
```

Add DNS
```
~ $ sudo cat /etc/hosts | grep example
<public_ip> staging-guestbook.example.io
<public_ip> guestbook.example.io
~ $
```

#### - Stress/Load Generator
```
bash kubernetes/stress-generator.sh build
```

#### - Destroy environment

```
bash kubernetes/stress-generator.sh destroy
bash kubernetes/guestbook-app.sh destroy
bash kubernetes/k8s-cluster.sh destroy
```
