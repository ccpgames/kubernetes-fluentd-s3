kubernetes-fluentd-s3
===

[![Build Status](https://travis-ci.org/ccpgames/kubernetes-fluentd-s3.svg?branch=master)](https://travis-ci.org/ccpgames/kubernetes-fluentd-s3)

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

1. The container relies on [AWS instance launch profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html) so the launch profiles of the nodes and master require the following policy:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::log-bucket/logs/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::log-bucket/logs"
            ]
        }
    ]
}
```

2. The container uses a ConfigMap to configure the bucket and path where logs are stored. A sample ConfigMap is provided with the project.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubernetes-fluentd-s3-config
  namespace: kube-system
data:
  S3_LOGS_BUCKET_NAME: log-bucket
  S3_LOGS_BUCKET_PREFIX: log-path-prefix/logs/
  S3_LOGS_BUCKET_REGION: eu-west-1
```

Update the yaml file with your configuration and apply it with ```kubectl apply -f kubernetes-fluentd-s3.configmap.yaml```

3. Create the container with ```kubectl apply -f kubernetes-fluentd-s3.yaml

### Derived from some sources:

+ [Kubernetes fluentd-ES](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch/fluentd-es-image)
+ [Fluentd base image](https://github.com/fluent/fluentd-docker-image)
+ [Fluentd S3 plugin](https://docs.fluentd.org/articles/out_s3)
