# The values file for deploying Traefik

This project is aimed at developing values file for deploying Traefik by means of Helm.

The following arguments are enabled in all values files.

```shell
 --providers.kubernetescrd
 --providers.kubernetesingress
```

## How to install Traefik utilizing Helm

```shell
# We can use helm template to review all of the YAML files to be applied to the target Kubernetes cluster.
$ helm template traefik traefik/traefik --values=traefik/traefik-values-dev.yaml

# Installing Traefik
$ helm install traefik traefik/traefik --values=traefik/traefik-values-dev.yaml

# A given namespace could be specified in which the Traefik will be installed.
$ helm install --namespace=<NAMESPACE> traefik traefik/traefik --values=traefik/traefik-values-dev.yaml

# List all the deployed charts.
$ helm list
NAME   	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART        	APP VERSION
traefik	default  	1       	2020-10-12 16:25:03.188913 +0800 CST	deployed	traefik-9.4.3	2.3.1

# Expose the Traefik dashboard.
kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000

# We may change some values in the current Traefik deployment.
$ helm upgrade traefik traefik/traefik --values=traefik/traefik-values-dev.yaml --set deployment.replicas=3
```

We can then visit the Traefik dashboard via the following URL.
```shell
http://localhost:9000/dashboard/
```

## Test the deployment of Traefik

After having installed Traefik on GKE, we can then test the deployment. There is a test case consisting of a simple web applicatioin written in Go language called `whoami`. We're going to configure it to run in GKE without TLS support first. A further test case to run `whoami` will be provided as well in the end.

### Run `whoami` in GKE without TLS support

```shell=
$ kubectl create -f tests/whoami.yaml
service/whoami created
deployment.apps/whoami created
ingressroute.traefik.containo.us/simpleingressroute created

$ kubectl get po
NAME                       READY   STATUS    RESTARTS   AGE
traefik-57b99b9cfc-p9ttt   1/1     Running   0          5h5m
traefik-57b99b9cfc-q9svf   1/1     Running   0          4h4m
traefik-57b99b9cfc-s2pk6   1/1     Running   0          4h4m
whoami-bd6b677dc-5px6s     1/1     Running   0          9s
whoami-bd6b677dc-bbv6k     1/1     Running   0          9s
```

From the above query results, two `whoami` instances whose status should be running. We cannot, however, reach them from outside the GKE without add the A Record (`whoami`) pointing to the IP address of Traefik’s LoadBalancer.

```shell=
$ kubectl get svc
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)                      AGE
kubernetes   ClusterIP      172.19.0.1     <none>           443/TCP                      3d23h
traefik      LoadBalancer   172.19.2.25    35.201.xxx.xxx   80:30014/TCP,443:31977/TCP   5h17m
whoami       ClusterIP      172.19.3.180   <none>           80/TCP                       12m
```

After having checked the IP address of Traefik's LoadBalancer in `EXTERNAL-IP`, we add a record to `/etc/hosts` as follows.

```shell=
$ sudo vi /etc/hosts

# Add the following record to /etc/hosts
35.201.xxx.xxx whoami.bigdata-dev.tk
```

We can then open the browser and visit the following URL.

```shell
http://whoami.bigdata-dev.tk/notls
```

The following response should be seen.

```shell=
Hostname: whoami-bd6b677dc-5px6s
IP: 127.0.0.1
IP: 172.18.0.69
RemoteAddr: 172.18.0.68:44830
GET /notls HTTP/1.1
Host: whoami.bigdata-dev.tk
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate
Accept-Language: zh-TW,zh;q=0.9,en-US;q=0.8,en;q=0.7
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
X-Forwarded-For: 10.201.xxx.xxx
X-Forwarded-Host: whoami.bigdata-dev.tk
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: traefik-57b99b9cfc-q9svf
X-Real-Ip: 10.201.xxx.xxx
```
