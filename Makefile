all: build push

build:
	docker build -t ccpgames/kubernetes-fluentd-s3:latest .

push:
	docker push ccpgames/kubernetes-fluentd-s3:latest

deploy:
	@echo 'Deleting existing deployment'
	@kubectl delete -f kubernetes-fluentd-s3.yaml || echo 'No deployment found, carrying on'
	@echo 'Creating new deployment'
	@kubectl create -f kubernetes-fluentd-s3.yaml
