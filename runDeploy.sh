#!/bin/bash

set -e  # Interrompe o script em caso de erro
set -x  # Exibe os comandos no terminal para depuração

REGION="us-east-1"
CLUSTER_NAME="carstore-eks"
export AWS_PROFILE=carstore
export AWS_REGION=us-east-1

# Inicializar e aplicar o Terraform
echo "Inicializando Terraform..."
cd ./envs/dev
terraform init
terraform plan

#terraform destroy -auto-approve
terraform apply -auto-approve


# Configurar kubeconfig para o cluster EKS
echo "Configurando o acesso ao cluster EKS..."
aws eks --region us-east-1 update-kubeconfig --name carstore-eks --profile carstore

# Selecionar o contexto correto
kubectl config use-context carstore-eks



echo "Deploy completo com sucesso! Todos os manifestos aplicados."
