#!/bin/bash

set -e
set -x

REGION="us-east-1"
CLUSTER_NAME="carstore-eks"
NODEGROUP_NAME="carstore-eks-nodegroup"

ACTION=$1

if [[ "$ACTION" != "start" && "$ACTION" != "stop" ]]; then
  echo "Uso: $0 <start|stop>"
  exit 1
fi

if [ "$ACTION" == "stop" ]; then
  echo "Parando o Node Group para evitar cobranças..."
  aws --profile carstore eks update-nodegroup-config \
    --cluster-name $CLUSTER_NAME \
    --nodegroup-name $NODEGROUP_NAME \
    --scaling-config minSize=0,maxSize=0,desiredSize=0 \
    --region $REGION

  echo "Node Group pausado com sucesso!"
elif [ "$ACTION" == "start" ]; then
  echo "Iniciando o Node Group..."
  aws --profile carstore eks update-nodegroup-config \
    --cluster-name $CLUSTER_NAME \
    --nodegroup-name $NODEGROUP_NAME \
    --scaling-config minSize=1,maxSize=3,desiredSize=1 \
    --region $REGION

  echo "Node Group iniciado com sucesso!"
fi

echo "Ação concluída: $ACTION"
