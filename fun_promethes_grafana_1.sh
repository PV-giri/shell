#!/bin/sh
prometheus() {
	if [ $? == 0 ]; then
		echo "$1 $2 is existed"
	else
		echo "$1 $2 doesn't existed"
		echo "$3 $1 $2"
		if [ $1 == "Namespace" ]; then
			# Create new namespace in kubernetes cluster
			kubectl create namespace mon
		else if [ $1 == "prometheus-community" ]; then
			helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
		else
			# Install  prometheus-community/kube-prometheus-stack
			helm install prometheus prometheus-community/kube-prometheus-stack -n mon
		fi
	fi
	fi
}
### check Namespace existnce or not ###
kubectl get ns | grep -w mon  >> /dev/null 2>&1
prometheus Namespace mon Creating
### check prometheus-community repo  existance or not ###
helm repo list | grep -w prometheus-community >> /dev/null 2>&1
prometheus prometheus-community repo Adding
### check kube-Promethues-stack is existance or not in cluster ####
kubectl get svc -n mon | grep -w kube-prometheus-stack >> /dev/null 2>&1
prometheus kube-promethues-stack deployment starting
### check pod status running or not ###
kubectl get pods -n mon >> /dev/null 2>&1
prometheus pods running status
echo "**"
