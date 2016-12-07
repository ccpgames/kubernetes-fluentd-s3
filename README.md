kubernetes-fluentd-s3
===

A docker container designed for kubernetes, forwarding logs to AWS S3.

Nodes and masters in the cluster must have permissions through IAM instance profile roles to write to the bucket.

## Build

Either clone the repository and perform build:

```bash
docker build -t ccpgames/kubernetes-fluentd-s3 .
```

Or use the public image available from DockerHub:

```bash
docker pull ccpgames/kubernetes-fluentd-s3
```

## Usage


### Derived from some sources:

+ [Kubernetes fluentd-ES](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch/fluentd-es-image)
+ [Fluentd base image](https://github.com/fluent/fluentd-docker-image)
+ [Fluentd S3 plugin](https://docs.fluentd.org/articles/out_s3)
