#!/bin/sh
prometheus() {
	if [ $? == 0 ]; then
		echo "$1 $2 is existed"
	else
		echo "$1 $2 doesn't existed"
		echo "$3 $1 $2"
	fi
}
### check Namespace existnce or not ###
kubectl get ns | grep -w mon  >> /dev/null 2>&1
prometheus Namespace mon Creating
# Create new namespace in kubernetes cluster
kubectl create namespace mon
### check prometheus-community repo  existance or not ###
helm repo list | grep -w prometheus-community >> /dev/null 2>&1
prometheus prometheus-community repo Adding
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
### check kube-Promethues-stack is existance or not in cluster ####
kubectl get svc -n mon | grep -w kube-prometheus-stack >> /dev/null 2>&1
prometheus kube-promethues-stack deployment starting
# Install  prometheus-community/kube-prometheus-stack
helm install prometheus prometheus-community/kube-prometheus-stack -n mon
### check pod status running or not ###
kubectl get pods -n mon >> /dev/null 2>&1
prometheus pods running status
echo "****"
