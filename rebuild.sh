#!/bin/sh
minikube delete
minikube start --vm-driver=virtualbox --cpus=2 --memory=2g --disk-size=5g
eval $(minikube docker-env)
minikube addons enable metallb
kubectl get pods
kubectl delete pods nginx-deployment-78564799df-tfj96
kubectl get deploy
kubectl delete deploy nginx-deployment # удаление деплоя nginx
kubectl get svc
kubectl delete svc nginx-svc
docker build -t nginx-image ./nginx
kubectl apply -f srcs/configmap.yaml
kubectl apply -f srcs/nginx.yaml
#kubectl describe pods nginx
minikube dashboard
